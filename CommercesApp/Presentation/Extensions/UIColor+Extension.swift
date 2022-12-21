import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


extension UIColor {
    
    static var infoViewDarkColor: UIColor {
        .init(rgb: 0x081c44)
    }
    
    static var mainScreenBackgroundColor: UIColor {
        .lightGray.withAlphaComponent(0.08)
    }

    static var gasStationColor: UIColor {
        .orange
    }
    
    static var leisureColor: UIColor {
        .init(rgb: 0x983cdc)
    }
    
    static var restaurantColor: UIColor {
        .init(rgb: 0xffc802)
    }
    
    static var shoppingColor: UIColor {
        .init(rgb: 0xb82c5c)
    }
    
    static var electricStationColor: UIColor {
        .systemBlue
    }
    
    static var directSalesColor: UIColor {
        .systemGreen
    }
    
    static var beautyColor: UIColor {
        .systemPurple
    }
    
}
