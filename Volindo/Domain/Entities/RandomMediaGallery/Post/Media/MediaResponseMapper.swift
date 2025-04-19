import Foundation

extension MediaResponse{
    enum MediaType: String, Codable {
        case image
        case video
        
        init(from decoder: Decoder) throws {
            
            let value = try decoder.singleValueContainer().decode(String.self)
            if value.hasPrefix("image/jpeg") || value.hasPrefix("image/png")  {
                self = .image
            } else {
                self = .video
            }
        }
    }
}
