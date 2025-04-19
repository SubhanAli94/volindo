import Foundation

struct RandomMediaApiResponse: Codable {
    let data: [PostResponse]
    let success: Bool
    let status: Int
}
