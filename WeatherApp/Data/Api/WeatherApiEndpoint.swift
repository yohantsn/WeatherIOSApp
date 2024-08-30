//
//  WeatherApiEndpoint.swift
//  WeatherApp
//
//  Created by CTW02177-Admin on 13/08/2024.
//

import Foundation

struct WeatherApiEndpoint{
    private static let baseUrl = "https://open-weather13.p.rapidapi.com"
    static func latlonUrl(coordinates: Coordinates) -> String {
        return "\(baseUrl)/city/latlon/\(coordinates.lat)/\(coordinates.lon)"
    }
}
