import Combine
import SwiftUI

struct FetchRandomMediaUseCaseMock: RandomMediaUseCase {
    var mockResult: Result<[PostResponse], Error>
    
    init(result: Result<[PostResponse], Error> = .success(RandomMediaApiResponse.mockRandomMediaData)) {
        self.mockResult = result
    }
    
    func execute(page: Int) -> AnyPublisher<[PostResponse], Error> {
        Future { promise in
            // Simulate a network delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                promise(self.mockResult)
            }
        }
        .eraseToAnyPublisher()
    }
}

