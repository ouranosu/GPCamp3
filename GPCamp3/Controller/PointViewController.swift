//
//  PointViewController.swift
//  GPCamp3
//
//  Created by work on 2019/12/15.
//  Copyright © 2019 Masahiro Okura. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation
import PopupDialog
import AudioToolbox

class PointViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var lastUseLabel: UILabel!
    @IBOutlet weak var useButton: UIButton!
    
    private var myLocationManager: CLLocationManager!
    private var myBeaconRegion: CLBeaconRegion!
    private var beaconUuids: NSMutableArray!
    private var beaconDetails: NSMutableArray!
    
    private let UUID = MyKeyClass().MyUUID
    let isUseablePoint: Int = 3 //使用可能ポイント
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ダークモード回避
        self.overrideUserInterfaceStyle = .light
    
        //データベース関係
        let realm = try! Realm()
        let point = PointClass()
        let res = realm.objects(PointClass.self)
        
        //もし初めてでデータベースがない場合、ポイント０、最終利用日空白でデータ入力
        if res.count == 0 {
            try! realm.write {
                point.point = 0
                point.lastUseDate = ""
                point.isPointGetYet = false
                realm.add(point)
            }
        }else{
            //２回目以降は
            pointTimeCheck()
        }
        
        //ラベル表示
        self.pointLabel.text = String(res.last!.point)
        self.lastUseLabel.text = String(res.last!.lastUseDate)
        
        //pointButtonAbleでボタンの有効性チェック 引数はPointClassのPoint
        pointButtonAble(pointCheck: res.last!.point)
        
        //ビーコン関係
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        //距離制度
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = 1 //メートル
        myLocationManager.activityType = .fitness //歩行者対象
        
        let status = CLLocationManager.authorizationStatus()
        print("CLAuthorizedStatus: \(status.rawValue)")
        if(status == .notDetermined){
            myLocationManager.requestAlwaysAuthorization()
        }
        beaconUuids = NSMutableArray()
        beaconDetails = NSMutableArray()
    }
    
    //画面更新
    override func viewDidAppear(_ animated: Bool) {
        let realm = try! Realm()
        let res = realm.objects(PointClass.self)
        //ラベル表示
        self.pointLabel.text = String(res.last!.point)
        self.lastUseLabel.text = String(res.last!.lastUseDate)
        //ボタンの可否不可避
        pointButtonAble(pointCheck: res.last!.point)
    }
    
    //ビーコンのモニタリング
    private func startMyMonitoring(){
        let uuid: NSUUID! = NSUUID(uuidString: "\(UUID)")
        let identifierStr: String = "GPCampFront"
        myBeaconRegion = CLBeaconRegion(uuid: uuid as UUID, identifier: identifierStr)
        myBeaconRegion.notifyEntryStateOnDisplay = false
        myBeaconRegion.notifyOnEntry = true
        myBeaconRegion.notifyOnExit = true
        myLocationManager.startMonitoring(for: myBeaconRegion)
    }
    
    //ビーコン用
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        //ユーザーが位置情報サービスを使用するかどうかを選択していない
        case .notDetermined:
            print("not Determind")
            break
        //位置情報サービスの使用を許可されていない
        case .restricted:
            print("restricted")
            break
        //位置情報サービスの使用を拒否したか、設定でグローバルに無効になっている
        case .denied:
            print("denied")
            break
        //ユーザーがアプリがいつでも位置情報サービスの使用を承認した
        case .authorizedAlways:
            print("authorizedAlways")
            startMyMonitoring()
            break
        //ユーザーがアプリの使用中に限り位置情報サービスの使用を承認した
        case .authorizedWhenInUse:
            print("authorizedWhtnInUse")
            startMyMonitoring()
            break
        default:
            break
        }
    }
    
    //観測の開始に成功すると呼ばれる
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        manager.requestState(for: region)
    }
    
    
    //ビーコン用
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .inside:
            //print("beacon inside")
            manager.startRangingBeacons(satisfying: myBeaconRegion.beaconIdentityConstraint)
            break
        case .outside:
            //print("outside")
            manager.stopRangingBeacons(satisfying: myBeaconRegion.beaconIdentityConstraint)
            break
        case .unknown:
            print("unknown")
            break
        default:
            print("unknown")
            break
        }
    }
    
    //ビーコン用
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        
        beaconUuids = NSMutableArray()
        beaconDetails = NSMutableArray()
        
        if(beacons.count > 0){
            for i in 0 ..< beacons.count{
                let beacon = beacons[i]
                let rssi = beacon.rssi
                /*
                let beaconUUID = beacon.proximity
                let minorID = beacon.minor
                let majorID = beacon.major
                let rssi = beacon.rssi
                var proximity = ""
                switch beacon.proximity {
                case CLProximity.unknown:
                    break
                case CLProximity.far:
                    break
                case CLProximity.immediate:
                    break
                case CLProximity.near:
                    break
                default:
                    print("default")
                }
                */
                
                let realm = try! Realm()
                let results = realm.objects(PointClass.self)
                /*
                if results.count == 0 {
                    try! realm.write {
                        results.last?.point += 1
                        results.last?.isPointGetYet = true
                        results.last?.pointGetDay = Date()
                    }
                }
                */
                if let res = results.last {
                    if rssi > -60 && res.isPointGetYet == false {
                        try! realm.write {
                            res.point += 1
                            res.isPointGetYet = true
                            res.pointGetDay = Date()
                        }
                        //ラベル表示
                        self.pointLabel.text = String(res.point)
                        pointButtonAble(pointCheck: res.point)
                        AudioServicesPlaySystemSound(1519) //短いバイブレーション
                    } else if rssi > -60 && res.isPointGetYet == true {
                        makeNotUseableAlert()
                        manager.stopRangingBeacons(satisfying: myBeaconRegion.beaconIdentityConstraint)
                    } else if beacon.proximity == CLProximity.far || beacon.proximity == CLProximity.unknown {
                        return
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion: iBeacon found")
        manager.startRangingBeacons(satisfying: myBeaconRegion.beaconIdentityConstraint)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didEnterRegion: iBeacon lost")
        manager.stopRangingBeacons(satisfying: myBeaconRegion.beaconIdentityConstraint)
    }
    
    //Create Function------------------------------
    
    //ポイント取得できませんalert
    func makeNotUseableAlert(){
        let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "ポイントを取得できませんでした。\n４２時間以上開けてから再度お試しください。", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            return
        })
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //ポイント取得の時間制限
    //ポイント取得後、時間でisPointGetYetをfalseにする
    //更新時間は２日後　
    func pointTimeCheck(){
        
        let realm = try! Realm()
        let res = realm.objects(PointClass.self)
        let pointGetDay = res.last!.pointGetDay
        
        //比較のためのフォーマット
        let format = DateFormatter()
        format.timeStyle = .none
        format.dateStyle = .medium
        format.locale = Locale(identifier: "ja-jp")
        let judgeDay = Calendar.current.date(byAdding: .day, value: 2, to: pointGetDay)!
        let now = Date()
        
        let fJudgeDay = format.string(from: judgeDay)
        let fNow = format.string(from: now)
 
        //日付が取得日と2日以上違えばisPointGetYetをFalseにする
        if fJudgeDay <= fNow {
            try! realm.write {
                res.setValue(false, forKey: "isPointGetYet")
            }
        }
    }
    
    //ポイント利用ボタンの可否
    func pointButtonAble(pointCheck: Int) -> Void{
        //ポイント利用ボタンのenable/disable
        if pointCheck < isUseablePoint {
            self.useButton.isEnabled = false
            self.useButton.backgroundColor = .cyan
            self.useButton.alpha = 0.4
        }else{
            self.useButton.isEnabled = true
            self.useButton.backgroundColor = .cyan
            self.useButton.alpha = 1.0
        }
    }
    
    
    //Outlet Function------------------------------
    //ポイント使うボタン
    @IBAction func UsePoint(_ sender: Any) {
        //日付の処理
        let formatToDay = getToday()
        
        //アラートでyes,no
        let alertController = UIAlertController(title: "確認", message: "\(isUseablePoint)ポイント利用します", preferredStyle: UIAlertController.Style.alert)
        //OK時
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action: UIAlertAction!) -> Void in

            //PopupDialogを使ってチケット表示
            //OKを押されたら処理
            let title = "チケット使用確認"
            let message = "チケットを使用しますか？"
            let image = UIImage(named: "coupon1")
            
            let popUp = PopupDialog(title: title, message: message, image: image)
            let button1 = CancelButton(title: "Cancel"){
                return
            }
            
            let button2 = DefaultButton(title: "OK", height: 60){
                let realm = try! Realm()
                let res = realm.objects(PointClass.self)
                try! realm.write {
                    res.last!.point -= self.isUseablePoint
                    res.last!.lastUseDate = formatToDay
                    //ラベル表示
                    self.pointLabel.text = String(res.last!.point)
                    self.lastUseLabel.text = String(res.last!.lastUseDate)
                    self.pointButtonAble(pointCheck: res.last!.point)
                }
            }
            
            popUp.addButtons([button1, button2])
            
            self.present(popUp, animated: true, completion: nil)
            
        })
        
        //キャンセル時
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
            (action: UIAlertAction!) -> Void in
            print("キャンセルされました")
        })
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
}

