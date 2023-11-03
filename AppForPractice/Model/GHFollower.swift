
import Foundation
import SwiftUI

struct GithubFollower: Codable, Identifiable, Hashable {
    let id: Int
    let login: String
    let avatarUrl: String
}

