//
//  UIApplication+Extensions.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 20.12.2021.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        self.sendAction(#selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil)
    }
}

extension Color {
    static var random: Color {
        Color(.displayP3, red: Double.random(in: 0..<256)/255, green: Double.random(in: 0..<256)/255, blue: Double.random(in: 0..<256)/255, opacity: 1)
    }
}
