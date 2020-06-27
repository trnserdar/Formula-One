//
//  Font+Custom.swift
//  FormulaOne
//
//  Created by Serdar Turan on 27.06.2020.
//

import Foundation
import SwiftUI

extension Font {
    
    static var customLargeTitle: Font {
        get {
            return Font.custom("Formula1-Display-Bold", size: 32.0)
        }
    }
    
    static var customTitle: Font {
        get {
            return Font.custom("Formula1-Display-Bold", size: 20.0)
        }
    }
    
    static var customCallout: Font {
        get {
            return Font.custom("Formula1-Display-Regular", size: 14.0)
        }
    }
    
    static var customHeadline: Font {
        get {
            return Font.custom("Formula1-Display-Bold", size: 15.0)
        }
    }
    
    static var customSubheadline: Font {
        get {
            return Font.custom("Formula1-Display-Regular", size: 13.0)
        }
    }
    
    static var customBody: Font {
        get {
            return Font.custom("Formula1-Display-Regular", size: 15.0)
        }
    }
    
    static var customCaption: Font {
        get {
            return Font.custom("Formula1-Display-Regular", size: 11.0)
        }
    }
}
