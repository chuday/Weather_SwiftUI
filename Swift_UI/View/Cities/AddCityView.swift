//
//  AddCityView.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 11.12.2021.
//

import SwiftUI

struct AddCityView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentation
    @State var cityname: String = ""
    
    private let screenWidth = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.frame.width ?? 0
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Add new city:")
            TextField("name", text: $cityname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: screenWidth/3)
            HStack(spacing: 0) {
                Button("Ok") {
                    try? City.create(in: self.managedObjectContext, name: self.cityname, imageName: nil)
                    self.presentation.wrappedValue.dismiss()
                }
                .frame(width: screenWidth/6)
                .disabled(cityname.isEmpty)
                
                Button("Cancel") {
                    self.presentation.wrappedValue.dismiss()
                }
                .frame(width: screenWidth/6)
            }
        }
    }
}
