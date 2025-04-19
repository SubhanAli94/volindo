import Combine

struct FetchStoryMock: StoryUsecase {
    func execute() -> [Story] {
        Story.storiesData
    }
}

