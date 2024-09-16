//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by CTW02177-Admin on 16/09/2024.
//

import Foundation
import CoreLocation

class WeatherViewModel : NSObject, ObservableObject, CLLocationManagerDelegate{
    let api = WeatherApi()
    let manager = CLLocationManager()
    @Published var weather : Weather? = nil
    @Published var coordinates: Coordinates = Coordinates(lat: 0, lon: 0)
    @Published var isLoading: Bool = false
    
    
    func refreshWeather() async throws -> Void{
        isLoading = true
        weather = try await api.getLatLonWeather(coordinates: coordinates);
        isLoading = false
    }
    
    func getUserPosition() async {
        manager.requestAlwaysAuthorization()
    }
    
    func checkLocationAuthorization() {
            
            manager.delegate = self
            manager.startUpdatingLocation()
            
            switch manager.authorizationStatus {
            case .notDetermined://The user choose allow or denny your app to get the location yet
                manager.requestWhenInUseAuthorization()
                
            case .restricted://The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
                print("Location restricted")
                
            case .denied://The user dennied your app to get location or disabled the services location or the phone is in airplane mode
                print("Location denied")
                
            case .authorizedAlways://This authorization allows you to use all location services and receive location events whether or not your app is in use.
                print("Location authorizedAlways")
                
            case .authorizedWhenInUse://This authorization allows you to use all location services and receive location events only when your app is in use
                print("Location authorized when in use")
                let lastKnownLocation = manager.location?.coordinate
                coordinates = Coordinates(lat: lastKnownLocation?.latitude ?? 0.0, lon: lastKnownLocation?.longitude ?? 0.0)
                
            @unknown default:
                print("Location service disabled")
            
            }
        }
    
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {//Trigged every time authorization status changes
            checkLocationAuthorization()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let lastKnownLocation = locations.first?.coordinate
            coordinates = Coordinates(lat: lastKnownLocation?.latitude ?? 0, lon: lastKnownLocation?.longitude ?? 0)
            
        }
}
