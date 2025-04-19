import Foundation
import Alamofire
import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?
    ) -> AnyPublisher<T, Error>
}

final class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
    ) -> AnyPublisher<T, Error> {
        Future { promise in
            AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let decodedObject):
                        promise(.success(decodedObject))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
