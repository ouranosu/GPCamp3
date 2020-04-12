//
//  WeatherClass.swift
//  GPCamp3
//
//  Created by work on 2020/01/07.
//  Copyright © 2020 Masahiro Okura. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherRealm: Object {
    @objc dynamic var dateToDay: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var summary: String = ""
    @objc dynamic var tempMax: String = ""
    @objc dynamic var tempMin: String = ""
    @objc dynamic var dateNextDay: String = ""
    @objc dynamic var icon2: String = ""
    @objc dynamic var summary2: String = ""
    @objc dynamic var tempMax2: String = ""
    @objc dynamic var tempMin2: String = ""
    @objc dynamic var weatherGetFlag: Bool = false
}

class WeatherModel{
    static func getWeatherApi(completion: @escaping([WeatherCodable]) -> Void){
        
        //DarkSky API
        let myKey = MyKeyClass().DarkSkyKey
        let myLatitude = "35.372836"
        let myLongitude = "136.361653"
        let url: URL = URL(string: "https://api.darksky.net/forecast/\(myKey)/\(myLatitude),\(myLongitude)?units=si&lang=ja")!
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        
        let task = URLSession.shared.dataTask(with: request.url!){ data, response, error in
            
            guard let jsonData = data else {
                return
            }
            
            do{
                let json = try JSONDecoder().decode(WeatherCodable.self, from: jsonData)
                completion([json])
            } catch {
                print(error)
                return
            }
        }
        task.resume()
    }
}

struct WeatherCodable: Codable{
    let daily: daily
    struct daily: Codable {
        var data: [data]
    }
}

struct data: Codable{
    var summary: String
    var icon: String
    var temperatureHigh: Double
    var temperatureLow: Double
}

enum IconClass: String{
    
    case clearday
    case cloudy
    case rain
    case snow
    case wind
    
}

func SelectIconCase(IconName: String) -> String{
    
    switch IconName {
    case IconClass.clearday.rawValue:
        return "icon1"
    case IconClass.cloudy.rawValue:
        return "icon2"
    case IconClass.rain.rawValue:
        return "icon3"
    case IconClass.wind.rawValue:
        return "icon4"
    case IconClass.snow.rawValue:
        return "icon5"
    default:
        return "icon1"
    }
}

func selectIcon(realmIconName: String) -> String{
    switch realmIconName {
    case "clear-day", "clear-night":
        let iconName = SelectIconCase(IconName: "clearday")
        return iconName
    case "partly-cloudy-day", "partly-cloudy-night", "cloudy":
        let iconName = SelectIconCase(IconName: "cloudy")
        return iconName
    case "rain":
        let iconName = SelectIconCase(IconName: "rain")
        return iconName
    case "wind":
        let iconName = SelectIconCase(IconName: "wind")
        return iconName
    case "snow", "sleet":
        let iconName = SelectIconCase(IconName: "snow")
        return iconName
    default:
        let iconName = SelectIconCase(IconName: "clearday")
        return iconName
    }
}
