// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Media file represent an audio file on the file system.
/// Through this file the MFS controls the position of the file in the file system
/// while giving external access to the URL for playback.
///
/// The MediaFile is created from the file URL and from there it guesses the id and the name.
/// but those can be modified externaly to e.g. setting the proper ID of a `new` file.
/// Using `fileName` one can get a properly formated file name.
public struct MediaFile {

    // Full file URL taking the form `file:///users/.../Inbox/myFile.mp3`
    let url: URL

    // The last part of the file URL taking the form `Inbox/myFile.mp3`
    // Notice no `/` before the folder.
    public let tailURL: URLComponents

    public var id: String? {
        didSet { isDirty = true }
    }

    public var name: String {
        didSet { isDirty = true }
    }

    // A media type can be managed only if all needed data is in place.
    public var canBeManaged: Bool { !((id?.isEmpty ?? true) || name.isEmpty) }

    // Dirty will be set to true when any of the properties of the
    // MediaFile has been altered.
    var isDirty: Bool

    /// Is new means that the file was found in the inbox and it will
    /// treated as a new file so the id will be nil and the name will
    /// be the full file name.
    public let isNew: Bool

    /// Internal constructor.
    /// Only the MediaFileSystem can create MediaFiles.
    /// Internal constructor.
    /// - Parameters:
    ///   - url: The File URL.
    ///   - isNew: When the file is not yet managed it has not been renamed with `id` and `name`, then
    ///   it is considered new. that means that the `id` will be nil and the reset of the file name will
    ///   be the name.
    init?(url: URL,
          isNew: Bool = false) {

        self.url = url
        if let tail = MediaFile.getTailURL(from: url) {
            self.tailURL = tail
        } else { return nil }
        self.isNew = isNew

        // set the values of id and name
        do {
            self.id = try MediaFile.idFromURL(url: url, isNew: isNew)
            self.name = try MediaFile.nameFromURL(url: url, isNew: isNew)
        } catch { return nil }

        self.isDirty = false
    }

    /// This public static variable provides the base folder where the files are taken
    /// from. We should be using this everywhere inside this package but not externaly.
    /// It is offered externally to allow for testing the creation of media files on a fake
    /// environment to later be able to play with them, and making test independent
    /// of the documents folder or icloud.
    public static var baseURL: () -> URL? = {
        let fileMng = FileManager.default
        let docsURL = try? fileMng.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        return docsURL
    }

    /// Geting the tail from a url.
    ///
    /// It is offered publicly to allow for creating tails that are compatible
    /// with MediaFile for testing purposes.
    ///
    /// - Parameter url: a URL of the form `file:///users/Inbox/myFile.mp3`
    /// - Returns: a partial url of the form: `Inbox/myFile.mp3`
    public static func getTailURL(from url: URL) -> URLComponents? {

        guard let docsURL = MediaFile.baseURL() else { return nil }

        // Using Strings remove the common part (the documents folder).
        // Notice that we are using the `absoluteString` to get the full path
        // including the `/`. as a result we will get something like `Inbox/myfile.mp3`
        let tailPath = url.absoluteString.replacingOccurrences(
            of: docsURL.absoluteString,
            with: "")

        // From that section of path create a URLComponent that contains that
        // path section.
        if let tailPathURL = URL(string: tailPath),
           let tailComponents = URLComponents(url: tailPathURL, resolvingAgainstBaseURL: false) {
            return tailComponents
        }

        // NOTE: I'm creating a URLComponent for two reasons:
        // 1. It conveys better may intention (that is a URL) than using regular string.
        // 2. The original URL can be reconstructing very easily like this:
        //    `let reconstructedURL = relPathComponents.url(relativeTo: baseURL)!`

        return nil
    }

    // MARK: - Getting the name and id from the URL.

    static let allowedExtensions = ["mp3", "mp4"]

    enum Error: Swift.Error {
        case unsupportedMediaFile
        case invalidFileURL
    }

    /// Extract the id from the url of the file.
    /// When it is new the whole file name is the name and the id will be nil.
    /// When it is not new the expected format is `id - name` or `id-name`.
    /// - Parameters:
    ///   - url: the URL
    ///   - isNew: shows that the file is new
    /// - Returns: the id extracted from the URL.
    static func idFromURL(url: URL, isNew: Bool = false) throws -> String? {

        if isNew {
            return nil
        } else {

            let fullFileName = url.lastPathComponent
            if let values = extractUUIDAndName(fullFileName) {
                if let idString = values.0 {
                    return idString
                } else {
                    return nil
                }
            } else {
                throw Error.invalidFileURL
            }
        }
    }

    /// Extract the name from the url of the file.
    /// When it is new the whole file name is the name and the id will be nil.
    /// When it is not new the expected format is `id - name` or `id-name`.
    /// - Parameters:
    ///   - url: the URL
    ///   - isNew: shows that the file is new
    /// - Returns: the name extracted from the URL.
    static func nameFromURL(url: URL, isNew: Bool = false) throws -> String {

        let ext = url.pathExtension
        guard allowedExtensions.contains(ext) else { throw Error.unsupportedMediaFile }

        let fullFileName = url.lastPathComponent
        if let values = extractUUIDAndName(fullFileName) {
            return values.1.trimmingCharacters(in: NSCharacterSet.whitespaces)
        } else {
            throw Error.invalidFileURL
        }
    }

    static func extractUUIDAndName(_ fileName: String) -> (String?, String)? {
        // The matching pattern for "<UUID> - <text>" being the spaces and the hypen optional.
        let pattern = "^([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})\\s?-?\\s?(.*)$"

        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])

            // remove the extention from the fileName
            let fileURL = URL(fileURLWithPath: String(fileName))
            let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent

            // Find matches in the text
            let matches = regex.matches(
                in: fileNameWithoutExtension,
                options: [],
                range: NSRange(location: 0, length: fileNameWithoutExtension.utf16.count)
            )

            // Check if there is a match
            if let match = matches.first {
                if let range1 = Range(match.range(at: 1), in: fileNameWithoutExtension),
                   let range2 = Range(match.range(at: 2), in: fileNameWithoutExtension) {
                    let idPattern: String? = String(fileNameWithoutExtension[range1])
                    let restOfString = fileNameWithoutExtension[range2]

                    // A file name with just ID is invalid
                    if restOfString.count == 0 { return nil }
                    // Remove the extension if any.
                    let fileURL = URL(fileURLWithPath: String(restOfString))
                    let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent
                    return (idPattern, fileNameWithoutExtension)
                }
            } else {
                // No matching to return the text without the extension
                return (nil, fileNameWithoutExtension)
            }
        } catch {
            // Ups Exception with the regex.
            return nil
        }
        return nil
    }

    // MARK: - Getting the file name from name and id

    /// Get the name to use on create or update a file.
    var fileName: String {

        if let id, !isNew {
            return id + "-" + name + "." + url.pathExtension
        } else {
            return name + "." + url.pathExtension
        }
    }

    /// The `fileName` method will send the "right" name of the file
    /// according to its state (new), but for managing the file we might
    /// need the file that it will take when managed, including the id
    /// independendly of the current state.
    var managedFileName: String {

        if let id {
            return id + "-" + name + "." + url.pathExtension
        } else {
            return name + "." + url.pathExtension
        }
    }
}

extension MediaFile: CustomStringConvertible {

    public var description: String {
"""
    MediaFile: id: \(id ?? "nil"), name: \(name), isDirty: \(isDirty), isNew: \(isNew)
               url: \(url)
"""
    }
}
