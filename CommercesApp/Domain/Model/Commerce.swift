struct Commerce: Codable {
    let photo: String
    let name: String
    let category: String
    let cashback: Float?
    let location: [Double]
    let openingHours: String
    let address: Address
    
    var commerceCategory: CommerceCategory {
        switch self.category {
            case "GAS_STATION":
                return .gasStation
            case "FOOD":
                return .restaurant
            case "LEISURE":
                return .leisure
            case "SHOPPING":
                return .shopping
            case "ELECTRIC_STATION":
                return .electricStation
            case "DIRECT_SALES":
                return .directSales
            case "BEAUTY":
                return .beauty
            default:
                // TODO: add default
                return .gasStation
        }
        
    }
}

struct Address: Codable {
    let street: String
    let city: String
    let state: String?
    let zip: String?
    let country: String
}
