//
//  Weather.swift
//  WeatherApp
//
//  Created by CTW02177-Admin on 13/08/2024.
//

import Foundation
 
struct Weather : Decodable{
    
    static func fromData(data: Data) throws -> Weather{
        return Weather()
    }
    
}
