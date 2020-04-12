//
//  DateFunction.swift
//  GPCamp3
//
//  Created by work on 2020/03/01.
//  Copyright © 2020 Masahiro Okura. All rights reserved.
//

import Foundation

func getToday() -> String {
    let formatter = DateFormatter()
    let now = Date()
    var formatToDay: String!
    
    //日付扱い
    formatter.dateStyle = .full
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "ja_JP")
    formatToDay = formatter.string(from: now)
    
    return formatToDay
}
