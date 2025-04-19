import Combine

protocol RandomMediaUseCase {
    func execute(page: Int) -> AnyPublisher<[PostResponse], Error>
}

