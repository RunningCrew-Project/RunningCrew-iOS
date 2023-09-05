//
//  UIColor+.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import Foundation
import UIKit

extension UIColor {
    class var tabBarSelect: UIColor? { return UIColor(named: "TabBarItemSelectColor") }
    class var tabBarBorder: UIColor? { return UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00) }
    class var darkGreen: UIColor? { return UIColor(red: 0.11, green: 0.39, blue: 0.21, alpha: 1.00) }
    class var darkGray: UIColor { return UIColor(red: 0.43, green: 0.40, blue: 0.41, alpha: 1.00) }
    class var lightGray: UIColor { return UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00) }
    class var lightGreen: UIColor? { return UIColor(red: 0.14, green: 0.65, blue: 0.33, alpha: 1.00) }
    class var darkModeBasicColor: UIColor? { return UIColor(named: "DarkModeBasicColor") }
}
