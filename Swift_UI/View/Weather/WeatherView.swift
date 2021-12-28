//
//  WeatherView.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 27.12.2021.
//

import SwiftUI
import Kingfisher

struct WeatherView: View {
    let weather: Weather
    let index: Int?
    @Binding var selection: Int?
    @Binding var displayedCellIndexes: Set<Int>
    
    var body: some View {
        return GeometryReader { proxy in
            VStack {
                Text(String(format: "%.0f℃", self.weather.temperature))
                KFImage(self.weather.iconUrl)
                    .cancelOnDisappear(true)
                Text(DateFormatter.forecastFormat(for: self.weather.date))
                    .frame(width: proxy.size.width)
            }
            .preference(key: WeatherHeightPreferenceKey.self, value: proxy.size.width)
            .anchorPreference(key: SelectionPreference.self, value: .bounds) {
                index == self.selection ? $0 : nil
            }
            .onTapGesture {
                withAnimation(.default) {
                    self.selection = index
                }
            }
            .onAppear {
                if let index = index {
                    displayedCellIndexes.insert(index)
                }
            }
            .onDisappear {
                if let index = index {
                    displayedCellIndexes.remove(index)
                }
            }
        }
    }
}

struct WeatherHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct SelectionPreference: PreferenceKey {
    static let defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value ?? nextValue()
    }
}

struct SelectionRectangleMatchedGeometryEffect: View {
    var body: some View {
        GeometryReader { proxy in
            Rectangle()
                    .fill(Color.clear)
                    .border(Color.blue, width: 2)
                    .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

