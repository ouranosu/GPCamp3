//
//  InsertWeaterRealm.swift
//  GPCamp3
//
//  Created by work on 2020/03/01.
//  Copyright © 2020 Masahiro Okura. All rights reserved.
//

import Foundation
import RealmSwift

func insertWeaterRealm(){
    /*
    let formatter = DateFormatter()
    let now = Date()
    var formatToDay: String!
    
    //日付扱い
    formatter.dateStyle = .full
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "ja_JP")
    formatToDay = formatter.string(from: now)
    */
    let formatToDay = getToday()
    
    WeatherModel.getWeatherApi(completion: {(WeatherJson) in
        //新規登録
        let realm = try! Realm()
        let weather = WeatherRealm()
        try! realm.write {
            weather.summary = WeatherJson[0].daily.data[0].summary
            weather.icon = WeatherJson[0].daily.data[0].icon
            weather.tempMax = String(ceil(WeatherJson[0].daily.data[0].temperatureHigh))
            weather.tempMin = String(ceil(WeatherJson[0].daily.data[0].temperatureLow))
            weather.summary2 = WeatherJson[0].daily.data[1].summary
            weather.icon2 = WeatherJson[0].daily.data[1].icon
            weather.tempMax2 = String(ceil(WeatherJson[0].daily.data[1].temperatureHigh))
            weather.tempMin2 = String(ceil(WeatherJson[0].daily.data[1].temperatureLow))
            weather.dateToDay = formatToDay
            realm.add(weather)
        }
    })
}

func updateWeaterRealm(){
    /*
    let formatter = DateFormatter()
    let now = Date()
    var formatToDay: String!
    
    //日付扱い
    formatter.dateStyle = .full
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "ja_JP")
    formatToDay = formatter.string(from: now)
     */
    
    let formatToDay = getToday()
    
    WeatherModel.getWeatherApi(completion: {(WeatherJson) in
        //更新するだけ
        let realm = try! Realm()
        let weather = realm.objects(WeatherRealm.self).last
        try! realm.write {
            weather!.summary = WeatherJson[0].daily.data[0].summary
            weather!.icon = WeatherJson[0].daily.data[0].icon
            weather!.tempMax = String(ceil(WeatherJson[0].daily.data[0].temperatureHigh))
            weather!.tempMin = String(ceil(WeatherJson[0].daily.data[0].temperatureLow))
            weather!.summary2 = WeatherJson[0].daily.data[1].summary
            weather!.icon2 = WeatherJson[0].daily.data[1].icon
            weather!.tempMax2 = String(ceil(WeatherJson[0].daily.data[1].temperatureHigh))
            weather!.tempMin2 = String(ceil(WeatherJson[0].daily.data[1].temperatureLow))
            weather!.dateToDay = formatToDay
        }
    })
}
