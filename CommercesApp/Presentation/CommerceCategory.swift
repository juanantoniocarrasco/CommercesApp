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
                return .restaurantColor
            case .leisure:
                return .leisureColor
            case .shopping:
                return .systemPink
            case .electricStation:
                return .systemBlue
            case .directSales:
                return .systemGreen
            case .beauty:
                return .systemPurple
        }
    }
    
    var iconWhite: UIImage? {
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
                return UIImage(named: "Electric Scooter_white")
            case .directSales:
                return UIImage(named: "Truck_white")
            case .beauty:
                return UIImage(named: "Car wash_white")
        }
    }
    
    var iconColour: UIImage? {
        switch self {
            case .gasStation:
                return UIImage(named: "EES_colour")
            case .restaurant:
                return UIImage(named: "Catering_colour")
            case .leisure:
                return UIImage(named: "Leisure_colour")
            case .shopping:
                return UIImage(named: "Cart_colour")
            case .electricStation:
                return UIImage(named: "Electric Scooter_colour")
            case .directSales:
                return UIImage(named: "Truck_colour")
            case .beauty:
                return UIImage(named: "Car wash_colour")
        }
    }
    
    var name: String {
        switch self {
            case .gasStation:
                return "Estaciones de servicio"
            case .restaurant:
                return "Restaurantes"
            case .leisure:
                return "Ocio"
            case .shopping:
                return "Compras"
            case .electricStation:
                return "Recarga Eléctrica"
            case .directSales:
                return "Gasóleos a domicilio"
            case .beauty:
                return "Salud y belleza"
        }
    }
}
