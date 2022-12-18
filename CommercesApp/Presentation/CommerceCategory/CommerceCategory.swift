import UIKit

enum CommerceCategory: CaseIterable {
    case gasStation
    case restaurant
    case leisure
    case shopping
    case electricStation
    case directSales
    case beauty
    
    var color: UIColor {
        switch self {
            case .gasStation:
                return .gasStationColor
            case .restaurant:
                return .restaurantColor
            case .leisure:
                return .leisureColor
            case .shopping:
                return .shoppingColor
            case .electricStation:
                return .electricStationColor
            case .directSales:
                return .directSalesColor
            case .beauty:
                return .beautyColor
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
