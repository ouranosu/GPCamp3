//
//  MapSelectClass.swift
//  GPCamp3
//
//  Created by work on 2019/12/20.
//  Copyright © 2019 Masahiro Okura. All rights reserved.
//

import Foundation
import MapKit

enum MapSelect: Int{
    
    case Free
    case Auto
    case Group
    case Bq1
    case Bq2
    case Kitchen1
    case Kitchen2
    case Wc1
    case Wc2
    case Playground
    
}

func MakeCoordinate(_ SelectCell: Int) -> [CLLocationCoordinate2D]{
    
    var coordinate = [CLLocationCoordinate2D]()
    
    switch  SelectCell{
    case MapSelect.Free.rawValue:
        //領域をcoordinateListに追加する
        //フリーサイト
        coordinate.append(CLLocationCoordinate2D(latitude: 35.376426, longitude: 136.361016))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375636, longitude: 136.360956))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375641, longitude: 136.360588))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.374786, longitude: 136.360558))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.374946, longitude: 136.359312))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.376468, longitude: 136.359297))
        
    case MapSelect.Auto.rawValue:
        //オートキャンプ
        coordinate.append(CLLocationCoordinate2D(latitude: 35.376431, longitude: 136.361225))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375170, longitude: 136.361176))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375170, longitude: 136.361004))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.376442, longitude: 136.361027))
        
    case MapSelect.Group.rawValue:
        //グループキャンプ
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375045, longitude: 136.360950))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.374721, longitude: 136.360941))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.374728, longitude: 136.360598))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375059, longitude: 136.360603))
        
    case MapSelect.Bq1.rawValue:
        //BBQ
        //昼の部・夜の部
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375519, longitude: 136.360955))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375170, longitude: 136.360950))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375225, longitude: 136.360670))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375567, longitude: 136.360648))
        
    case MapSelect.Bq2.rawValue:
        //日中の部
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375732, longitude: 136.361893))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375615, longitude: 136.361879))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375604, longitude: 136.361361))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375692, longitude: 136.361351))
        
    case MapSelect.Kitchen1.rawValue:
        //炊事場
        //BBQ横
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375461, longitude: 136.360641))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375300, longitude: 136.360619))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375295, longitude: 136.360533))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375422, longitude: 136.360566))
        
    case MapSelect.Kitchen2.rawValue:
        //遊具横
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375221, longitude: 136.360479))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375020, longitude: 136.360473))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375002, longitude: 136.360347))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375221, longitude: 136.360342))
    
    case MapSelect.Wc1.rawValue:
        //トイレ
        //BBQ横
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375556, longitude: 136.360955))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375426, longitude: 136.360955))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375435, longitude: 136.360802))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.375587, longitude: 136.360785))
        
    case MapSelect.Wc2.rawValue:
        //遊具横
        coordinate.append(CLLocationCoordinate2D(latitude: 35.374929, longitude: 136.360206))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.374850, longitude: 136.360201))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.374833, longitude: 136.360057))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.374920, longitude: 136.360035))
        
    case MapSelect.Playground.rawValue:
        //ドラゴンスライダー
        coordinate.append(CLLocationCoordinate2D(latitude: 35.371641, longitude: 136.361559))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.371266, longitude: 136.361548))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.371248, longitude: 136.360644))
        coordinate.append(CLLocationCoordinate2D(latitude: 35.371702, longitude: 136.360637))
        
    default:
        print("defaultが選択されました")
    }
    
    return coordinate
}
