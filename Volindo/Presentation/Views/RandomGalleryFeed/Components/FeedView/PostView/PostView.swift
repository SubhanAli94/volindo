import SwiftUI
import AVKit
import Kingfisher

struct PostView: View {
    let postv2: PostResponse
    @State var isCaptionExpanded = false
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                
                Circle()
                    .fill(ColorUtils.randomDarkColor())
                    .frame(width: 42, height: 42)
                    .padding(.all, 2)
                    .overlay(
                        Circle()
                            .stroke(
                                AngularGradient(
                                    gradient: Gradient(colors: [.red, .orange, .yellow, .orange, .red, .purple, .red]),
                                    center: .center
                                ),
                                lineWidth: 2
                            )
                    )
                
                Text(postv2.accountUrl ?? "Anonymous")
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .frame(width: 15, height: 10)
                    .padding(.leading, 15)
                    .padding(.vertical, 8)
            }
            .padding(.horizontal, 16)
            
            
            PostMediaView(mediaContents: postv2.mediaContent)
            
            VStack(alignment: .leading, spacing: 5){
                HStack(spacing: 10) {
                    UserReactionsView(iconName: "heart", noOfReactions: postv2.favoriteCount)
                    
                    UserReactionsView(iconName: "message", noOfReactions: postv2.commentCount)
                    
                    UserReactionsView(iconName: "paperplane", noOfReactions: postv2.views)
                    
                    Spacer()
                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .padding(5)
                        .padding(.trailing, 10)
                }
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading){
                    
                    Text(styledComment(username: postv2.accountUrl ?? "Anonymous", comment: postv2.title))
                        .font(.body) // ensure consistent line spacing
                        .lineLimit(isCaptionExpanded ? nil : 2)
                        .truncationMode(.tail)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isCaptionExpanded.toggle()
                            }
                        }
                    
                    Text(postv2.formattedDate)
                        .foregroundColor(.gray)
                        .font(.caption)
                        .padding(.top, 1)
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    private func styledComment(username: String, comment: String) -> AttributedString {
        var fullText = AttributedString("\(username) \(comment)")
        if let range = fullText.range(of: username) {
            fullText[range].font = .subtitle.bold() // use bold subtitle for username
        }
        return fullText
    }
    
    private func UserReactionsView(iconName: String, noOfReactions: Int) -> HStack<TupleView<(some View, Text)>> {
        return HStack(spacing: 1){
            Image(systemName: iconName)
                .resizable()
                .frame(width: 22, height: 20)
                .padding(5)
            Text(noOfReactions.formattedString())
                .font(.subtitle)
        }
    }
}
