import Foundation

extension Story {
    static let storiesData = fetchStories()
}

private func fetchStories() -> [Story] {
    guard let url = Bundle.main.url(forResource: "StoriesMock", withExtension: "json") else {
        print("Error: Could not find StoriesMock.json")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode([Story].self, from: data)
        return response
    } catch {
        print("Error decoding JSON: \(error)")
        return []
    }
}
