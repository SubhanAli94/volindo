import Foundation

struct PostResponse: Codable {
    let id: String
    let title: String
    let type: String?
    let link: String
    let mp4: String?
    let accountUrl: String?
    let commentCount: Int
    let favoriteCount: Int
    let views: Int
    let mediaItems: [MediaResponse]?
    let datetime: Int
    let isAlbum: Bool
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case type
        case link
        case mp4
        case commentCount = "comment_count"
        case favoriteCount = "favorite_count"
        case accountUrl = "account_url"
        case views
        case mediaItems = "images"
        case isAlbum = "is_album"
        case datetime
    }
}
