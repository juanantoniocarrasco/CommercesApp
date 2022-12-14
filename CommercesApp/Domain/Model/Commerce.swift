struct Commerce: Codable {
    let photo: String
    let name: String
    let category: String
    let cashback: Int
    let location: [Double]
    let openingHours: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
    let state: String
    let zip: String
    let country: String
}
