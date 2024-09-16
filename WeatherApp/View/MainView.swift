//
//  MainView.swift
//  WeatherApp
//
//  Created by CTW02177-Admin on 16/09/2024.
//

import Foundation
import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text("LAT \(viewModel.coordinates.lat)").padding(.vertical, 8)
            Text("LON \(viewModel.coordinates.lon)").padding(.vertical, 8)
            ButtonComponent(isLoading: viewModel.isLoading, text: "REFRESH") {
                Task{
                    do{
                        try await viewModel.refreshWeather()
                    }
                }
                
            }.padding(.horizontal, 16)
        }
    }
}

struct WeatherView_Preview: PreviewProvider {
    static var previews: some View{
        MainView(viewModel: WeatherViewModel())
    }
}
