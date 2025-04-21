//
//  WeatherModelMapper.swift
//  clima
//
//  Created by axel tadeo on 21/04/25.
//

import Foundation

struct WeatherModelMapper {
    func mapDataModelToModel(dataModel: WeatherResponseDataModel) -> WeatherModel {
        guard let weather = dataModel.weather.first else {
            return .empty
        }
        
        let temperature = dataModel.temperature
        
        let sunsetWithTimezone = dataModel.sun.sunset.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        let sunriseWithTimezone = dataModel.sun.sunrise.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        
        return WeatherModel(city: dataModel.city,
                            weather: weather.main,
                            description: "(\(weather.description))",
                            iconURL: URL(string: "https://openweathermap.org/ing/wn/\(weather.iconURLString)@2x.png"),
                            currentTemperature: "\(Int(temperature.currentTemperature))º",
                            minTemperature: "\(Int(temperature.minTemperature))º Min.",
                            maxTemperature: "\(Int(temperature.maxTemperature))º Max.",
                            humidity: "\(temperature.humidity)%",
                            sunset: sunsetWithTimezone,
                            sunrise: sunriseWithTimezone)
    }
}
