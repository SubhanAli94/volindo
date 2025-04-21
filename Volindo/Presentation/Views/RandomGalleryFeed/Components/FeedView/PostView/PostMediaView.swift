import SwiftUI
import AVKit

struct PostMediaView: View {
    let mediaContents: [MediaContent]
    let id = UUID()
        
    @State private var currentIndex: Int = 0
    
    
    var body: some View {
        Group {
            if mediaContents.count == 1 {
                albumMediaView(mediaContents.first!, 0)
            } else {
                VStack{
                    TabView(selection: $currentIndex) {
                        ForEach(Array(mediaContents.enumerated()), id: \.offset) { index, item in
                            albumMediaView(item, index)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(width: UIScreen.screenWidth, height: UIScreen.postMediaItemHeight)
                    
                    HStack(spacing: 5) {
                        ForEach(mediaContents.indices, id: \.self) { index in
                            Circle()
                                .fill(index == currentIndex ? Color.blue.opacity(0.8) : Color.gray.opacity(0.2))
                                .frame(width: 6, height: 6)
                        }
                    }
                    .padding(.bottom, 8)
                }
            }
        }
    }
    
    @ViewBuilder
    private func albumMediaView(_ item: MediaContent, _ index: Int) -> some View {
        switch item {
        case .image(let url):
            
            WideImageView(link: url)
        case .video(let url, _ ):
            
            videoPlayer(url: URL(string: url)!, index: index)
        }
    }
    
    private func videoPlayer(url: URL, index: Int) -> some View {
        let player = AVPlayer(url: url)
        return VideoPlayer(player: player)
            .clipped()
            .frame(width: UIScreen.screenWidth, height: UIScreen.postMediaItemHeight)
            .onAppear {
                PlaybackManager.shared.register(id: id, player: player)
            }
            .onDisappear {
                PlaybackManager.shared.unregister(id: id)
            }
        
            .background(GeometryReader { proxy in
                Color.gray
                    .preference(
                        key: VisibilityPreferenceKey.self,
                        value: [ id: visibilityFraction(of: proxy.frame(in: .named("scroll"))) ]
                    )
            })
    }
    
    private func visibilityFraction(of frame: CGRect) -> CGFloat {
        guard let scrollFrame = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows.first?
            .rootViewController?
            .view.frame
        else { return 0 }
        let intersection = frame.intersection(scrollFrame)
        return intersection.height / frame.height
    }
}

struct VisibilityPreferenceKey: PreferenceKey {
    static let defaultValue: [UUID: CGFloat] = [:]
    static func reduce(value: inout [UUID: CGFloat], nextValue: () -> [UUID: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
