import SwiftUI
import Kingfisher

struct WideImageView: View{
    let link: String
    
    var body: some View{
        
        KFImage(URL(string: link))
            .placeholder {
                Color.gray.opacity(0.3)
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.screenWidth)
            .frame(maxHeight: UIScreen.postMediaItemHeight)
            .clipped()
    }
}
