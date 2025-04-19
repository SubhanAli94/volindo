import Foundation
import UIKit
import Combine
import AVFoundation

class RandomGalleryFeedViewModel: ObservableObject {
    @Published var posts: [PostResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var hasMore = true
    @Published var visiblePostIDs = Set<String>()
    
    @Published private(set) var stories: [Story] = []
    
    private let randomMediaUseCase: RandomMediaUseCase
    private let storiesUseCase: StoryUsecase
    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 0
    private let prefetchThreshold = 20
    
    init(randomMediaUseCase: RandomMediaUseCase,
         storiesUseCase: StoryUsecase) {
        self.randomMediaUseCase = randomMediaUseCase
        self.storiesUseCase = storiesUseCase
    }
    
    func fetchRandomMedia(reset: Bool = false) {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        if reset {
            currentPage = 0
            posts.removeAll()
        }
        
        currentPage += 1
        
        randomMediaUseCase.execute(page: currentPage)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if case let .failure(error) = completion {
                        self?.errorMessage = error.localizedDescription
                        self?.currentPage -= 1
                    }
                }
            } receiveValue: { [weak self] newPosts in
                guard let self = self else { return }
                self.posts.append(contentsOf: newPosts)
                self.hasMore = !newPosts.isEmpty
                //TODO: prefetchMedia for new posts
            }
            .store(in: &cancellables)
    }
    
    func fetchMoreItemsIfNeeded(currentPost: PostResponse) {
        guard let currentIndex = posts.firstIndex(where: { $0.id == currentPost.id }) else {
            return
        }
        
        if( currentIndex >= posts.count - prefetchThreshold){
            fetchRandomMedia()
            print(posts.count)
        }
        
    }
    
    func calculateVisiblePosts(postFrames: [String: CGRect], scrollOffset: CGFloat) {
        let screenHeight = UIScreen.main.bounds.height
        let visibleRect = CGRect(x: 0, y: scrollOffset, width: UIScreen.main.bounds.width, height: screenHeight)
        
        let visibleIDs = postFrames
            .filter { visibleRect.intersects($0.value) }
            .map(\.key)
        
        DispatchQueue.main.async {
            self.visiblePostIDs = Set(visibleIDs)
        }
    }
    
    func shouldLoadMore(currentItem: PostResponse) -> Bool {
        guard let index = posts.firstIndex(where: { $0.id == currentItem.id }) else { return false }
        return index >= posts.count - 5
    }
}

extension RandomGalleryFeedViewModel {
    func fetchStories() {
        stories = storiesUseCase.execute()
    }
}
