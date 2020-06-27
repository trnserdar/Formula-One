//
//  UIColor+Hex.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

#if !os(macOS)
import UIKit

extension UIColor {
 
    convenience init(hex: String) {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    static var officialColor: UIColor {
        get {
            return UIColor(hex: "FF1801")
        }
    }
    
}
#endif
