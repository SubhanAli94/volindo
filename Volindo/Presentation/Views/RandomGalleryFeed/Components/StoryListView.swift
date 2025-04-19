import SwiftUI
import Kingfisher

struct StoryListView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: RandomGalleryFeedViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16){
                VStack(alignment: .center){
                    ZStack(alignment: .bottomTrailing) {
                        Image("lion") // Replace with your asset name
                            .resizable()
                            .scaledToFill()
                            .frame(width: 78, height: 78)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.white.opacity(0), lineWidth: 4)
                            )
                        
                        ZStack {
                            Circle()
                                .fill(colorScheme == .dark ? Color.white : Color.black)
                                .frame(width: 24, height: 24)
                            Image(systemName: "plus")
                                .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                                .font(.system(size: 14, weight: .bold))
                        }
                        .overlay(
                            Circle().stroke(colorScheme == .dark ? Color.black : Color.white, lineWidth: 3)
                        )
                    }
                    .padding(.top, 6)
                    Spacer()
                    Text("Your Story")
                        .font(.body)
                        .lineLimit(1)
                        .frame(maxWidth: 82)
                        .truncationMode(.tail)
                }
                .padding(.leading, 16)
                .frame(height: 110)
                ForEach(viewModel.stories, id: \.self) { story in
                    VStack {
                        
                        KFImage(URL(string: story.imageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 76, height: 76)
                            .clipShape(Circle())
                            .padding(.all, 4)
                            .overlay(
                                Circle()
                                    .stroke(
                                        AngularGradient(
                                            gradient: Gradient(colors: [.red, .orange, .yellow, .orange, .red, .purple, .red]),
                                            center: .center
                                        ),
                                        lineWidth: 3
                                    )
                            )
                            .padding(.top, 2)
                        
                        Spacer()
                        
                        Text(story.username)
                            .font(.body)
                            .lineLimit(1)
                            .frame(maxWidth: 78)
                            .truncationMode(.tail)
                    }
                    .frame(height: 110)
                }
            }
            .frame(alignment: .center)
        }
        .fixedSize(horizontal: false, vertical: true)
        .onAppear(){
            viewModel.fetchStories()
        }
    }
}

#Preview {
    StoryListView()
}
