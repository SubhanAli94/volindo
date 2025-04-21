import Foundation

extension Story {
    static let storiesData = fetchStories()
}

private func fetchStories() -> [Story] {
    guard let url = Bundle.main.url(forResource: "StoriesMock", withExtension: "json") else {
#if DEBUG
        print("Error: Could not find StoriesMock.json")
#endif
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode([Story].self, from: data)
        return response
    } catch {
#if DEBUG
        print("Error decoding JSON: \(error)")
#endif
        return []
    }
}
