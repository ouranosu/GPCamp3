//
//  HomeContainerViewController.swift
//  GPCamp3
//
//  Created by work on 2020/01/16.
//  Copyright © 2020 Masahiro Okura. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift


class HomeContainerViewController: UIViewController {

    /*
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var weatherMaxTempLabel: UILabel!
    @IBOutlet weak var weatherMinTempLabel: UILabel!
    @IBOutlet weak var weatherSummary: UILabel!
    
    
    @IBOutlet weak var tomorrowView: UIView!
    @IBOutlet weak var weatherTitle2: UILabel!
    @IBOutlet weak var weatherIconImage2: UIImageView!
    @IBOutlet weak var weatherMaxTempLabel2: UILabel!
    @IBOutlet weak var weatherMinTempLabel2: UILabel!
    @IBOutlet weak var weatherSummary2: UILabel!
    
    //let formatter = DateFormatter()
    //var now = Date()
    var formatToDay: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ダークモード回避
        self.overrideUserInterfaceStyle = .light
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        //日付扱い
//        formatter.dateStyle = .full
//        formatter.timeStyle = .none
//        formatter.locale = Locale(identifier: "ja_JP")
//        formatToDay = formatter.string(from: now)
//        print(formatToDay)
        formatToDay = getToday()
        
        //データベース関係
        let realm = try! Realm()
        let res = realm.objects(WeatherRealm.self)
        //print("realmのdb：\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        let queue = DispatchQueue.main
        
        if res.count == 0 {
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
                    weather.dateToDay = self.formatToDay
                    realm.add(weather)
                }
                queue.async {
                    self.DrowContainerView()
                }
            })
        } else if res.last!.dateToDay != formatToDay {
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
                weather!.dateToDay = self.formatToDay
                }
                queue.async {
                    self.DrowContainerView()
                }
            })
        } else {
            queue.async {
                self.DrowContainerView()
            }
        }
    }

    //create Function

    
    func DrowContainerView(){
        //データベース関係
        let realm = try! Realm()
        let res = realm.objects(WeatherRealm.self)
        //iconの画像の設定
        let iconName = selectIcon(realmIconName: res.last!.icon)
        let iconName2 = selectIcon(realmIconName: res.last!.icon2)
        
        self.weatherTitle.text = "今日の天気"
        self.weatherIconImage.image = UIImage(named: "\(iconName)")
        self.weatherMaxTempLabel.text = "最高気温：\(res.last!.tempMax)"
        self.weatherMinTempLabel.text = "最低気温：\(res.last!.tempMin)"
        self.weatherSummary.text = res.last!.summary
        
        self.weatherTitle2.text = "明日の天気"
        self.weatherIconImage2.image = UIImage(named: "\(iconName2)")
        self.weatherMaxTempLabel2.text = "最高気温：\(res.last!.tempMax2)"
        self.weatherMinTempLabel2.text = "最低気温：\(res.last!.tempMin2)"
        self.weatherSummary2.text = res.last!.summary2
    
    }
 */
}
