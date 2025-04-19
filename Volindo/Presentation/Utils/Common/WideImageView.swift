import SwiftUI
import Kingfisher

struct WideImageView: View{
    let link: String
    
    var body: some View{
        KFImage(URL(string: link))
            .placeholder{
                Color.gray.opacity(0.3)
                               .frame(width: UIScreen.screenWidth, height: UIScreen.postMediaItemHeight)
            }
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.screenWidth, height: UIScreen.postMediaItemHeight)
            .clipped()
    }
}
