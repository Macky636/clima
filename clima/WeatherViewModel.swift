//
//  WeatherViewModel.swift
//  clima
//
//  Created by axel tadeo on 21/04/25.
//

import Foundation
import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published var weatherModel: WeatherModel = .empty
    private var weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    
    func getWeather(city: String) async{
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=549a1d138bf66476550b7e8b78eca685")!
        
        do{
            async let (data, _) = try await URLSession.shared.data(from: url)
            let dataModel = try! await JSONDecoder().decode(WeatherResponseDataModel.self, from: data)
            DispatchQueue.main.async {
                self.weatherModel = self.weatherModelMapper.mapDataModelToModel(dataModel: dataModel)
            }
            
        }catch {
            print(error.localizedDescription)
        }
    }
}
