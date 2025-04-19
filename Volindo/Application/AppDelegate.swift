import Swinject
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    let container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        configureDependencies()
        return true
    }

    private func configureDependencies() {
        
        container.register(RandomMediaUseCase.self) { _ in
            RandomMediaService()
        }

        container.register(StoryUsecase.self) { _ in
            StoryService()
        }

        container.register(RandomGalleryFeedViewModel.self) { resolver in
            RandomGalleryFeedViewModel(
                randomMediaUseCase: resolver.resolve(RandomMediaUseCase.self)!,
                storiesUseCase: resolver.resolve(StoryUsecase.self)!
            )
        }.inObjectScope(.container)
    }
}
