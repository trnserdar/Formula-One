//
//  UIApplication+EndEditing.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

#if !os(macOS)
import UIKit

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
