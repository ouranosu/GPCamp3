//
//  HomeViewController.swift
//  GPCamp3
//
//  Created by work on 2019/12/15.
//  Copyright © 2019 Masahiro Okura. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseFirestore
import RealmSwift
import PopupDialog


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var infoTableView: UITableView!
    
    var db: Firestore!
    var infoReference: CollectionReference!
    var dataDic: [Dictionary<String, Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ダークモード回避
        self.overrideUserInterfaceStyle = .light
        //インジケーターのセット
        self.setLoadingView()
        //天気テーブルのセット
        self.setWeatherTable()
        //お知らせ
        self.setInfoTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        infoTableView.indexPathsForSelectedRows?.forEach{
            infoTableView.deselectRow(at: $0, animated: true)
        }
    }

    func setWeatherTable(){

        let realm = try! Realm()
        //天気
        let weatherRes = realm.objects(WeatherRealm.self)
        let formatToDay = getToday()
        
        if weatherRes.count == 0 {
            insertWeaterRealm()
        } else if weatherRes.last!.dateToDay != formatToDay {
            updateWeaterRealm()
        }
        
    }
    
    func setInfoTable(){
        self.db = Firestore.firestore()
        self.infoReference = self.db.collection("info")
        self.infoReference.getDocuments() {(querySnapshot, error) in
            if error != nil {
                print("error getting FireStoreDocuments")
                return
            } else {
                for document in querySnapshot!.documents {
                    self.dataDic.append(document.data())
                    self.homeTableView.reloadData()
                    self.infoTableView.reloadData()
                    
                    //処理終了でインディケーター消す こっちの方が自然な気がする
                    self.deleteLoadingView(parentView: self.view)
                }
            }
        }
    }
    
    func setLoadingView(){
        //透過して見えるようにvisualEffect
        let effectView = UIVisualEffectView()
        effectView.frame = CGRect(x:0 ,y: 0, width: self.view.frame.width, height: self.view.frame.height)
        effectView.backgroundColor = .gray
        effectView.alpha = 0.7
        effectView.tag = 1
        self.view.addSubview(effectView)
        
        //インジケーター
        let activitiIndicatorView = UIActivityIndicatorView()
        activitiIndicatorView.center = view.center
        activitiIndicatorView.color = .white
        activitiIndicatorView.tag = 2
        self.view.addSubview(activitiIndicatorView)
        activitiIndicatorView.startAnimating()
        
    }
    
    //不要になったeffectViewとIndicatorの削除
    func deleteLoadingView(parentView: UIView){
        for subView in parentView.subviews {
            if subView.tag != 0 {
                subView.removeFromSuperview()
            }
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        //スクロールバーをチラ見せ
        self.homeTableView.flashScrollIndicators()
        self.infoTableView.flashScrollIndicators()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == homeTableView {
            //天気のテーブルは当日と翌日の必ず２日間だけ
            return 2
        } else {
            //お知らせはディレクトリの数
            return dataDic.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == homeTableView {
            let weatherCell: UITableViewCell! = weatherCellGet(indexPath: indexPath)
            return weatherCell
        } else {
            let infoCell: UITableViewCell! = infoCellGet(indexPath: indexPath)
            return infoCell
        }
    }
    
    //セルの高さ調節
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == homeTableView {
            //天気
            return CGFloat(200)
        } else {
            //お知らせ
            return CGFloat(50)
        }
    }
    
    //お知らせのセル返し
    func infoCellGet(indexPath: IndexPath) -> UITableViewCell{
        let infoCell: UITableViewCell = infoTableView.dequeueReusableCell(withIdentifier: "InfoTableCell", for: indexPath)
        //タイトル
        let cellTitleLabel = infoCell.contentView.viewWithTag(1) as! UILabel
        cellTitleLabel.text = dataDic[indexPath.row]["title"] as? String
        
        return infoCell
    }
    
    //天気のセル返し
    func weatherCellGet(indexPath: IndexPath) -> UITableViewCell{
        
        let realm = try! Realm()
        let weatherRes = realm.objects(WeatherRealm.self)
        
        var iconName: [String] = ["", ""]
        var weatherTitle: [String] = ["", ""]
        var maxTemp: [String] = ["", ""]
        var minTemp: [String] = ["", ""]
        var summary: [String] = ["", ""]
        
        if weatherRes.count != 0 {
            iconName = [selectIcon(realmIconName: weatherRes.last!.icon), selectIcon(realmIconName: weatherRes.last!.icon2)]
            weatherTitle = ["今日の天気", "明日の天気"]
            maxTemp = [weatherRes.last!.tempMax, weatherRes.last!.tempMax2]
            minTemp = [weatherRes.last!.tempMin, weatherRes.last!.tempMin2]
            summary = [weatherRes.last!.summary, weatherRes.last!.summary2]
        }
        
        let weatherCell: UITableViewCell = homeTableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath)
        //画像
        let cellImageView = weatherCell.contentView.viewWithTag(1) as! UIImageView
        let cellImage = UIImage(named: iconName[indexPath.row])
        cellImageView.image = cellImage
        //タイトル
        let cellTitleLabel = weatherCell.contentView.viewWithTag(2) as! UILabel
        cellTitleLabel.text = weatherTitle[indexPath.row]
        //最高気温
        let cellMaxTemp = weatherCell.contentView.viewWithTag(3) as! UILabel
        cellMaxTemp.text = maxTemp[indexPath.row]
        //最低気温
        let cellMinTemp = weatherCell.contentView.viewWithTag(4) as! UILabel
        cellMinTemp.text = minTemp[indexPath.row]
        //サマリー
        let cellSummary = weatherCell.contentView.viewWithTag(5) as! UILabel
        cellSummary.text = summary[indexPath.row]
        
        return weatherCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == homeTableView {
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            let IDVC: InfoDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoDetail") as! InfoDetailViewController
            IDVC.infoTitleString = dataDic[indexPath.row]["title"] as? String
            IDVC.infoTextString = dataDic[indexPath.row]["text"] as? String
            self.present(IDVC, animated: true, completion: nil)
            
            print(dataDic[indexPath.row])
        }
    }
}
