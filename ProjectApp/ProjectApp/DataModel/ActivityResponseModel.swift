import Foundation

struct ActivityResponseModel : Codable {
    let activity: String
    let type: String
    let participants: Int64
    let price: Double
    let link: String
    let key: String
    let accessibility: Double
}
