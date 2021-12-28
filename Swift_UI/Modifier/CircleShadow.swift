//
//  CircleShadow.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 20.12.2021.
//

import SwiftUI

struct CircleShadow: ViewModifier {
    let shadowColor: Color
    let shadowRadius: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .shadow(color: shadowColor, radius: shadowRadius)
            content.clipShape(Circle())
        }
    }
}
