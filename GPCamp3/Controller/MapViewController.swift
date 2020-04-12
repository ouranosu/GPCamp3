//
//  MapViewController.swift
//  GPCamp3
//
//  Created by work on 2019/12/15.
//  Copyright © 2019 Masahiro Okura. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var TableView: UITableView!
    
    //変数
    //CLLocationManagerの入れ物
    var myLocationManager: CLLocationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D!
    
    //座標のリスト
    var coordinateList = [CLLocationCoordinate2D]()

    //テーブル用
    private let FacilityList = ["フリーサイト", "オートキャンプ", "グループキャンプ", "バーベキュー台(昼の部・夜の部)", "バーベキュー台(日中台)", "炊事場１", "炊事場２", "トイレ１", "トイレ２", "ドラゴンスライダー"]
    private let CellId = "mapTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ダークモード回避
        self.overrideUserInterfaceStyle = .light
        //マップの初期化
        initMap()
    }
    
    func initMap(){
        //位置情報使用許可のリクエストを表示するメソッド
        myLocationManager.requestWhenInUseAuthorization()
        
        self.MapView.showsUserLocation = true
        self.MapView.setUserTrackingMode(.follow, animated: true)
        self.MapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        
        //addPoint関数でピンを立てる
        //引数(緯度、軽度、タイトル名、サブタイトル名)
        self.addPoint(35.372948,136.360830,"【受付】鴨池荘","入浴施設があります")
        self.addPoint(35.375170,136.361790,"【受付】キャンプ場受付","販売・レンタルあります")
        self.addPoint(35.372415,136.362100,"【受付】GLAMP ELEMENT","高級キャンプ：グランピング施設")
        self.addPoint(35.371542,136.361665,"【遊】ドラゴンスライダー","１００メートルの滑り台！")
        self.addPoint(35.374195,136.362393,"【遊】天狗の丘","幼稚園〜小学生低学年向け")
        self.addPoint(35.372914,136.360160,"【遊】アスレサーキット","小学生以上向け")
        self.addPoint(35.374893,136.360226,"【遊】小さな遊具","２歳〜幼稚園向け、トイレ炊事場有り")
        self.addPoint(35.386252,136.363822,"【買】フレンドマート","最寄りのスーパー")
        self.addPoint(35.387599,136.363255,"【買】ドラッグゆたか","最寄りのドラッグストア")
        self.addPoint(35.384246,136.369364,"【買】セブン & i","最寄りのコンビニ")
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse{
            MapView.delegate = self
            myLocationManager.delegate = self
            myLocationManager.distanceFilter = 10
            myLocationManager.startUpdatingLocation()
        }
        //縮尺の設定
        let center = CLLocationCoordinate2DMake(35.374217, 136.360131)
        let span = MKCoordinateSpan(latitudeDelta: 0.00689,longitudeDelta: 0.00689)
        let region = MKCoordinateRegion(center: center, span: span)
        MapView.setRegion(region, animated: true)
    }
    
    //ピン作成関数
    func addPoint(_ latitude:CLLocationDegrees,_ longitude:CLLocationDegrees,_ title:String,_ subtitle:String){
        //ピン作成
        let annotation = MKPointAnnotation()
        //緯度軽度の指定
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        //タイトルとサブタイトルの設定
        annotation.title = title
        annotation.subtitle = subtitle
        //表示
        MapView.addAnnotation(annotation)
    }
    
    //ユーザーの位置取得
    func locationManager(manager:CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        userLocation = CLLocationCoordinate2DMake((manager.location?.coordinate.latitude)!, (manager.location?.coordinate.longitude)!)
    }
    
    //位置情報取得に失敗した時のメソッド
    func locationManager(_ manager:CLLocationManager, didFailWithError error: Error){
        print(error.localizedDescription)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FacilityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MapTableCell", for: indexPath)
        
        //ラベル
        let cellNameLabel = cell.contentView.viewWithTag(1) as! UILabel
        cellNameLabel.text = FacilityList[indexPath.row]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellId)
        
        return cell
    }
    
    //セルの高さ調整
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellCount: CGFloat = CGFloat(FacilityList.count)
        let cellHeight: CGFloat = TableView.frame.height/cellCount
        return CGFloat(cellHeight)
    }
    
    //セルタップ時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        //テーブルタップごとの初期化
        for id in MapView.overlays{
            MapView.removeOverlay(id)
        }
        coordinateList.removeAll()
        
        //エリアの表示範囲を取得するMapSelectClass.MakeCoordinate()
        coordinateList = MakeCoordinate(indexPath.row)
        
        //タップされた施設部分を囲って色付け
        let overlay = MKPolygon(coordinates: &coordinateList, count: coordinateList.count)
        MapView.addOverlay(overlay)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer: MKOverlayPathRenderer
        renderer = MKPolygonRenderer(overlay: overlay)
        
        //図形の色を生成
        renderer.fillColor = UIColor(red: 255/255,
                                     green: 80/255,
                                     blue: 80/255,
                                     alpha: 0.9
        )
        return renderer
    }
    
}
