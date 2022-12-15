import UIKit

enum CommerceCategory: String, CaseIterable {
    case gasStation = "GAS_STATION"
    case restaurant = "FOOD"
    case leisure = "LEISURE"
    case shopping = "SHOPPING"
    case electricStation = "ELECTRIC_STATION"
    case directSales = "DIRECT_SALES"
    case beauty = "BEAUTY"
    
    var color: UIColor {
        switch self {
                
            case .gasStation:
                return .orange
            case .restaurant:
                return .yellow
            case .leisure:
                return .systemBlue
            case .shopping:
                return .systemPink
            case .electricStation:
                return .orange
            case .directSales:
                return .orange
            case .beauty:
                return .orange
        }
    }
    
    var icon: UIImage? {
        switch self {
            case .gasStation:
                return UIImage(named: "EES_white")
            case .restaurant:
                return UIImage(named: "Catering_white")
            case .leisure:
                return UIImage(named: "Leisure_white")
            case .shopping:
                return UIImage(named: "Cart_white")
            case .electricStation:
                return UIImage(named: "EES_white")
            case .directSales:
                return UIImage(named: "EES_white")
            case .beauty:
                return UIImage(named: "EES_white")
        }
    }
    }
