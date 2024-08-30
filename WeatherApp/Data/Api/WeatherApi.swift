//
//  ApiInterface.swift
//  WeatherApp
//
//  Created by CTW02177-Admin on 13/08/2024.
//

import Foundation

enum WeatherApiException : Error{
  case unknown
}

protocol WeatherApiProtocol{
    func getLatLonWeather(coordinates: Coordinates) async throws -> Weather
}

class WeatherApi: WeatherApiProtocol{
    func getLatLonWeather(coordinates: Coordinates)async throws  -> Weather {
        
        do{
            let url = URLComponents(string: WeatherApiEndpoint.latlonUrl(coordinates: coordinates))
            
            var request = URLRequest(url: url!.url!)
            request.httpMethod = "GET"
            request.setValue("open-weather13.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
            request.setValue("2da19801b4mshb649081d17e1fa5p1cfb81jsn04b02bce861c", forHTTPHeaderField: "x-rapidapi-key")
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw WeatherApiException.unknown
            }
            
            guard let weather = try? Weather.fromData(data: data) else {

                throw WeatherApiException.unknown
            }
            
            return weather
            
        } catch{
            throw WeatherApiException.unknown
        }
    }
    
    
}
