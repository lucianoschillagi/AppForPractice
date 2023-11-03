
import SwiftUI

// TODO: then refactor #model (SwiftData)
// https://developer.apple.com/xcode/swiftdata/
class AppForPracticeViewModel: ObservableObject {
    
    @Published var ghFollowers = [GithubFollower]()
    
    @MainActor
    func fetchData() async {
        guard let downloadedGhFollowers: [GithubFollower] = await WebService().getGHFollowers() else { return }
        ghFollowers = downloadedGhFollowers
    }
}

