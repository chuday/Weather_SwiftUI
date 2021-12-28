//
//  ForecastView.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 11.12.2021.
//

import SwiftUI
import Kingfisher

struct ForecastView: View {
    @Namespace var namespace
    @ObservedObject var viewModel: ForecastViewModel
    let columns = [
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
        GridItem(.flexible(minimum: 0, maximum: .infinity)),
    ]
    @State private var weatherRowHeight: CGFloat? = nil
    @State private var selection: Int? = nil
    @State private var displayedCellIndexes: Set<Int> = []
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center, spacing: 16)  {
                    if let weathers = viewModel.weathers {
                        ForEach(weathers) { weather in
                            WeatherView(weather: weather,
                                        index: weathers.index(of: weather),
                                        selection: $selection,
                                        displayedCellIndexes: $displayedCellIndexes)
                                .frame(height: weatherRowHeight)
                                .matchedGeometryEffect(id: weathers.index(of: weather) ?? 0, in: namespace, isSource: true)
                        }
                    }
                }
            }
            .onAppear(perform: viewModel.fetchForecast)
            .navigationBarTitle(viewModel.city.name)
            .onPreferenceChange(WeatherHeightPreferenceKey.self) { height in
                weatherRowHeight = height
            }
            .overlay(
                Group {
                    if let selection = self.selection,
                       displayedCellIndexes.contains(selection) {
                        SelectionRectangleMatchedGeometryEffect()
                            .matchedGeometryEffect(id: selection, in: namespace, isSource: false)
                    }
                }
            )
        }
    }

}
