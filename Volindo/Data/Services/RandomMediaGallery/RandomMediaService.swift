import Foundation
import Alamofire
import Combine

final class RandomMediaService: RandomMediaUseCase {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func execute(page: Int) -> AnyPublisher<[PostResponse], Error> {
            let url = APIConstants.randomGallery
            let headers: HTTPHeaders = ["Authorization": APIConstants.clientId]
            let parameters: Parameters = ["page": page]

            return networkService.request(
                url: url,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: headers
            )
            .flatMap { (apiResponse: RandomMediaApiResponse) -> AnyPublisher<[PostResponse], Error> in
                if apiResponse.success {
                    return Just(apiResponse.data)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: URLError(.badServerResponse))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
        }
}
