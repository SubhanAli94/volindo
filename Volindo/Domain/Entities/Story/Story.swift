import Foundation

struct Story: Identifiable, Hashable, Codable {
    var id = UUID()
    let imageURL: String
    let username: String
    
    enum CodingKeys: CodingKey {
        case imageURL
        case username
    }
}
