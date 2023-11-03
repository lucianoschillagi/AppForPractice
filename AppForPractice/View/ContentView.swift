
import SwiftUI

struct ContentView: View {

    @StateObject var vm = AppForPracticeViewModel()
    @State private var selectedFollower: GithubFollower?
    
    @State private var isScreenLoading = true
    
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible()),
       ]
    
    var body: some View {
        // TODO: replace for NavigationStack
        // https://www.youtube.com/watch?v=GZ-hQWMjT0s
        NavigationView {
            if isScreenLoading {
                ProgressView()
            } else {
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(vm.ghFollowers) { follower in
                            VStack {
                                Text(follower.login)
                                NavigationLink(destination: DetailView(ghFollower: follower), tag: follower, selection: $selectedFollower) {
                                    AsyncImage(url: URL(string: follower.avatarUrl )) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.resizable()
                                                .clipShape(Circle())
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 50, maxHeight: 50)
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
                                }
                            }
                        }
                    }
                }
                
                
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("GitHub Followers")
        
        .onAppear {
            if vm.ghFollowers.isEmpty {
                Task {
                    await vm.fetchData()
                    self.isScreenLoading = false
                }
            } else {
                self.isScreenLoading = true
            }
        }
    }
}

#Preview {
    ContentView(vm: AppForPracticeViewModel())
}

