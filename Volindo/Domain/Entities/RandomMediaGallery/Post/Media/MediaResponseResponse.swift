import Foundation

struct MediaResponse: Codable {
    let id: String
    let type: MediaType
    let link: String
    let mp4: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case link
        case mp4
    }
}



