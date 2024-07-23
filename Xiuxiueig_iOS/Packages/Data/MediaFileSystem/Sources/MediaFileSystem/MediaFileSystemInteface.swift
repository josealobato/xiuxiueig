// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// Public interface of the Media File System allowing accessing the existing file
/// by state (managed, unmanaged,...), and allowing to modify the file and change its state.
///
/// # How to use it.
///
/// Use the builder to get an instance of this interface.
/// Once done that you can access the media files by interacting with the methods here.
///
/// ## Accessing existing media files
///
/// The first thing that you can do is to get the new files (`unmanagedFiles`) and the ones that
/// are already under th control of the system (`managedFiles`)
///
/// ## Changing the state (managed, unmanaged, archived) of media files
///
/// Once you have access to the files you can change their state (new, managed, archived) using the
/// corresponding methods. The regular flow of a file is:
///
/// ``` new -> managed <-> archived ```
///
/// Notice that once a file has been managed, you can not return it to new but you can archive
/// and unarchive the file at will.
///
/// ## About deleting files
///
/// You can also delete file no matter the state.
///
/// ## About demo media files
///
/// On first creation the system will create the containers to allocate the files and also add some
/// demo or tutorial files. If they are deleted you can force to recreate them with `resetDefaultMediaFiles`.
/// By default the files are located in new files to show the user the whole flow with files.
///
public protocol MediaFileSystemInteface: AutoMockable {

    /// Access to all the existing managed files.
    /// - Returns: a list of the existing media files
    func managedFiles() -> [MediaFile]

    /// Access to all the existing new files.
    /// - Returns: a list of the existing new files in the inbox.
    func unmanagedFiles() -> [MediaFile]

    /// Access to all archived Files
    /// - Returns: a list of the existing archived files.
    func archivedFiles() -> [MediaFile]

    /// Access to all discarded Files
    /// - Returns: a list of the existing discarded files.
    func discardedFiles() -> [MediaFile]

    /// Update a file name in the file system with the new information.
    /// Any file can be updated independently of it location, but is should be ready
    /// to be managed which means that it should be previously given and id and a name.
    /// Update file won't change the location of the file just its name.
    ///
    /// NOTE: Use updateFile only on managed files. Why? Because using it on a `isNew`
    ///       file will return a `isNew` file and those files do not have ID. 
    ///       Imagine you modify
    ///       the ID and the Name of a `isNew` file. When you update the file, 
    ///       you will change the name but the returned MediaFile will be still
    ///       `isNew` so the ID is gone and the id-name will be the name.
    /// NOTE: When you update the file you are physically moving the file, any old list of
    ///       files got from `manageFiles` or `unmanagedFiles` might containt incorrect
    ///       files.
    ///       so, do not keep these list our update always using those methods after
    ///       any other
    ///       modifying method.
    ///
    /// - Parameter file: The file to update.
    /// - Returns: the updated file, or nil if the action could not be done.
    func updateFile(file: MediaFile) -> MediaFile?

    /// Mark a file as managed.
    /// Only a file with proper id and name can be managed.
    /// - Parameter file: The file to manage.
    /// - Returns: The new managed file.
    func manageFile(file: MediaFile) -> MediaFile?

    /// Archive a file.
    /// Only a managed file can be archived.
    /// - Parameter file: The file to archive.
    /// - Returns: The new archived file.
    func archiveFile(file: MediaFile) -> MediaFile?

    /// Unarchive the give file.
    /// An unarchive file become a managed file.
    /// - Parameter file: the file to unarchive.
    /// - Returns: the new managed file.
    func unarchiveFile(file: MediaFile) -> MediaFile?

    /// delete a file
    /// - Parameter file: file to delete.
    func deleteFile(file: MediaFile)

    /// discard a file
    /// - Parameter file: file to discard
    /// - Returns: the discarded managed file.
    func discardFile(file: MediaFile) -> MediaFile?

    /// Recreate the folders if needed and set the default media files
    /// in place (the new files folder).
    func resetDefaultMediaFiles()
}
