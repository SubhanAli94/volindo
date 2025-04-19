import Foundation
extension RandomMediaApiResponse {
    static let mockRandomMediaData = fetchRandomMediaMock()
}

private func fetchRandomMediaMock() -> [PostResponse] {
    guard let url = Bundle.main.url(forResource: "RandomMediaApiResponseMock", withExtension: "json") else {
        print("Error: Could not find RandomMediaApiResponseMock.json")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(RandomMediaApiResponse.self, from: data)
        return response.data
    } catch {
        print("Error decoding JSON: \(error)")
        return []
    }
}
