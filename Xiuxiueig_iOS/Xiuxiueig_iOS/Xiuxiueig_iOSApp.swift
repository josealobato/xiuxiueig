import SwiftUI

@main
// swiftlint:disable:next type_name
struct Xiuxiueig_iOSApp: App {
    var body: some Scene {
        WindowGroup {

            // The app starts with the App Flow View. That is the entry flow of the
            // application and takes over as soon as the app starts.
            // At the moment the AppFlowView holds the coordinator, in the future we
            // might need access to the coordinator in this view. If that happen we could
            // move the coordinator here and injected to an @ObservedObject in the AppFlowView.
            AppFlowView()
        }
    }
}
