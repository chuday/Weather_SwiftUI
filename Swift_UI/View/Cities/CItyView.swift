//
//  CItyView.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 19.12.2021.
//

import SwiftUI

struct CityView: View {
    let city: City
    @State private var isScaled = false

    
    var body: some View {
        HStack {
            Image(city.name.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .center)
                .padding()
                .scaleEffect(isScaled ? 0.75 : 1)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        self.isScaled.toggle()
                    }
            Text(city.name)
        }
    }
}
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(city: City())
    }
}
