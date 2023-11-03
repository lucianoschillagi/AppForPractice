
import Foundation

class WebService: Codable {

    func getGHFollowers() async -> [GithubFollower]? {
        
        do {
            
            let endpoint = "https://api.github.com/users/twostraws/followers"
            
            guard let url = URL(string: endpoint) else { throw GHError.invalidUrl }
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw GHError.invalidResponse
                
                // improve this
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([GithubFollower].self, from: data)
        }
        
        // Error cases
        catch GHError.invalidUrl {
           print("Invalid URL")

        } catch GHError.invalidData {
           print("Invalid data")
        }
        catch GHError.invalidResponse {
           print("Invalid response")

        } catch {
           print("Unexpected error")
        }
        
        return nil
        
    }
    
    func deleteGHFollower(){}
    
}

