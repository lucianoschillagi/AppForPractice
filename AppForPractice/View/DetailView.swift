
import SwiftUI

struct DetailView: View {
    
    let ghFollower: GithubFollower
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: ghFollower.avatarUrl )) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200, maxHeight: 200)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
            
            Text(ghFollower.login)
                .font(.largeTitle)
            
            Text("ID: \(ghFollower.id)")
                .font(.subheadline)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Follower Details")
    }
}

#Preview {
    DetailView(ghFollower: GithubFollower(id: 42432, login: "Fernand", avatarUrl: "https://avatars.githubusercontent.com/u/42103934?v=4"))
}

