//
//  PointClass.swift
//  GPCamp3
//
//  Created by work on 2019/12/22.
//  Copyright © 2019 Masahiro Okura. All rights reserved.
//

import Foundation
import RealmSwift

class PointClass: Object{
    //ポイント数
    @objc dynamic var point: Int = 0
    //ポイント最終使用日時
    @objc dynamic var lastUseDate: String = ""
    //ポイント取得日
    @objc dynamic var pointGetDay: Date = Date()
    //ポイント取得一日一回制限フラグ
    @objc dynamic var isPointGetYet: Bool = false
    
}
