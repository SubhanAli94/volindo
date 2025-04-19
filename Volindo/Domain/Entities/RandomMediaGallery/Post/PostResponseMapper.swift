//
//  Mapper.swift
//  Instagram-Clone
//
//  Created by Usman Ali on 19/04/2025.
//

import Foundation

extension PostResponse{
    var formattedDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(123345345))
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d" // Example: "March 10"
        return formatter.string(from: date)
    }
    
    var mediaContent: [MediaContent] {
        var formattedMediaItems: [MediaContent] = []

        if !isAlbum, let type = type {
            if type.hasPrefix("image/jpeg") || type.hasSuffix("image/png") {
                formattedMediaItems.append(.image(url: link))
            } else if let mp4 = mp4 {
                formattedMediaItems.append(.video(url: mp4, id: id))
            }
            
        } else if let mediaItems = mediaItems, !mediaItems.isEmpty {
            
            
            if let videoItem = mediaItems.first(where: { $0.type == .video }) {
                let videoURL = videoItem.mp4 ?? videoItem.link
                formattedMediaItems.append(.video(url: videoURL, id: videoItem.id))
            }

            if let imageItem = mediaItems.first(where: { $0.type == .image }) {
                formattedMediaItems.append(.image(url: imageItem.link))
            }
            
            if formattedMediaItems.count > 1{
                print("Nothing")
            }
        }

        return formattedMediaItems
    }
}
