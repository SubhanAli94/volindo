import SwiftUI

struct RandomGalleryFeedView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            headerView()
            
            TrackableScrollView{
                VStack(spacing: 18){
                    StoryListView()
                    
                    FeedView()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.top, 14)
    }
    
    private func headerView() -> some View {
        HStack{
            HStack(spacing: 6){
                Text("Volindo")
                    .font(.CookieRegular(size: 38))
                    .accessibilityIdentifier(AccessibilityIdentifiers.HeaderView.logoText)
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .bold))
                    .padding(.top, 4)
                    .accessibilityIdentifier(AccessibilityIdentifiers.HeaderView.chevronDown)
            }
            Spacer()
            HStack(spacing: 20){
                Image(systemName: "heart")
                    .font(.system(size: 22))
                    .accessibilityIdentifier(AccessibilityIdentifiers.HeaderView.heartIcon)
                Image(systemName: "paperplane")
                    .font(.system(size: 22))
                    .rotationEffect(.degrees(15))
                    .accessibilityIdentifier(AccessibilityIdentifiers.HeaderView.messageIcon)
            }
        }
        .padding(.horizontal, 16)
        
    }
}

#Preview {
    RandomGalleryFeedView()
}
