import XCTest
import Combine
@testable import Volindo

final class RandomGalleryFeedViewModelStoriesTests: XCTestCase {
    // MARK: - Properties
    private var sut: RandomGalleryFeedViewModel!
    private var storyUseCase: MockStoryUseCase!
    private var cancellables: Set<AnyCancellable>!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        storyUseCase = MockStoryUseCase()
        cancellables = []
        sut = RandomGalleryFeedViewModel(
            randomMediaUseCase: MockRandomMediaUseCase(),
            storiesUseCase: storyUseCase
        )
        
        // Use real stories data from JSON in test bundle
        storyUseCase.stories = Story.storiesData
    }

    override func tearDown() {
        cancellables.removeAll()
        sut = nil
        storyUseCase = nil
        super.tearDown()
    }

    // MARK: - Initial State
    func test_initialState_storiesIsEmpty() {
        XCTAssertTrue(sut.stories.isEmpty, "Stories should be empty initially")
    }

    // MARK: - Fetch Success
    func test_fetchStories_populatesStoriesFromJSON() {
        // When
        sut.fetchStories()

        // Then
        let expectedStories = Story.storiesData
        XCTAssertEqual(sut.stories, expectedStories, "Should populate stories from JSON data")
    }

    // MARK: - Empty Response
    func test_fetchStories_handlesMissingJSON() {
        // Simulate missing JSON by returning empty array
        storyUseCase.stories = []

        // When
        sut.fetchStories()

        // Then
        XCTAssertTrue(sut.stories.isEmpty, "Should handle missing/invalid JSON")
    }

    // MARK: - Combine Integration
    func test_storiesPublisher_emitsJSONValues() {
        let publisherExpectation = expectation(description: "Publisher emits value")
        
        sut.$stories
            .dropFirst()
            .sink { stories in
                XCTAssertEqual(stories, Story.storiesData)
                publisherExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchStories()
        
        wait(for: [publisherExpectation], timeout: 1.0)
    }
}

private class MockRandomMediaUseCase: RandomMediaUseCase {
    var result: Result<[PostResponse], Error>!
    var executeCallCount = 0

    init() {
        result = .success([])
    }

    func execute(page: Int) -> AnyPublisher<[PostResponse], Error> {
        executeCallCount += 1
        switch result {
        case .success(let data):
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        @unknown default:
            return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
        }
    }
}

private class MockStoryUseCase: StoryUsecase {
    var stories: [Story] = []
    func execute() -> [Story] { stories }
}
