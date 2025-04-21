import SwiftUI
import AVFAudio


struct FeedView: View {
    @EnvironmentObject var viewModel: RandomGalleryFeedViewModel
    
    var body: some View {
        
        if viewModel.isLoading && viewModel.posts.isEmpty {
            ProgressView("Loading...")
        } else if let error = viewModel.errorMessage {
            VStack {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
                Button("Retry") {
                    viewModel.fetchRandomMedia(reset: true)
                }
            }
        } else {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.posts, id: \.id) { post in
                    PostView(postv2: post)
                        .padding(.top, 2)
                        .onAppear {
                            viewModel.fetchMoreItemsIfNeeded(currentPost: post)
                        }
                }
            }
            .onAppear{
                
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch {
                    print("Failed to set up audio session: \(error)")
                }
                
                viewModel.fetchRandomMedia(reset: true)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
