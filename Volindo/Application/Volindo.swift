import SwiftUI
import Swinject

@main
struct VolindoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RandomGalleryFeedView()
                .environmentObject(appDelegate.container.resolve(RandomGalleryFeedViewModel.self)!)
        }
    }
}
