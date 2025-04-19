
import SwiftUI

struct TrackableScrollView<Content: View>: View {
    
    let content: () -> Content
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            content()
                .padding(.vertical)
                .onPreferenceChange(VisibilityPreferenceKey.self) { vis in
                    PlaybackManager.shared.updateVisibility(vis)
                }
        }
        .coordinateSpace(name: "scroll")
    }
}
