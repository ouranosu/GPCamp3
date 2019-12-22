//
//  RentalViewController.swift
//  GPCamp3
//
//  Created by work on 2019/12/15.
//  Copyright © 2019 Masahiro Okura. All rights reserved.
//

import UIKit
import Hero
import RAMAnimatedTabBarController

class RentalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

private let photo = ["rental1","rental2","rental3","rental4",
               "rental5","rental6","rental7","rental8",
               "rental9","rental10","rental11","rental12",
               "rental13","rental14","rental15","rental16","rental17"]
private let itemName = ["1.SnowPeak アメニティドームM", "2.coleman ヘキサタープ",
                  "3.Logos エアマジックドーム","4.Logos エアマジックドーム　２ルーム",
                  "5.Snowpeak 焚火台","6.UniFrame BBQ台","7.Logos ロケットパワーランタン","8.Fermob バラッドランプ",
                  "9.Captain Stag ハンモック","10.Ogawa シュラフ","11.延長コード　三口","12.UniFrame 調理セット",
                  "13.Captain Stag テーブル","14.Captain Stag チェア","15.Yamazen サーキュレーター",
                  "16.ShopJapan ここひえ","17.Suaoki ポータブル電源"]
private let itemPrice = ["¥5,000","¥2,000","¥5,000","¥15,000",
                   "¥2,000","¥1,500","¥600","¥600",
                   "¥2,000","¥1,000","¥300","¥500",
                   "¥1,000","¥500","¥600","¥1,000","¥1,000"]
private let itemDetail = [
    "入門用テントとして圧倒的な人気を誇る、スノーピークの超ベストセラーテント。\n重量：8kg\n対応人数：5名\n室内高：150cm \nセット内容：テント本体、本体フレーム長（×3）、前室フレーム（×1）、ジュラルミンペグ（17cm×18）、自在付ロープ（1.4m×2、2.5m×2、2又5m×2）、インナーマット、グランドシート\n付属品：キャリーバッグ、フレームケース、ペグケース",
    "クロスポールを広げるだけで、高さ調整が可能。\n重量：5.9kg\n使用時サイズ：420×420×230(h)cm\n耐水圧：約1,500mm\nセット内容：タープ　ポール 約ø19mm×2、長さ 約260cm\n付属品：ペグ、ロープ、ハンマー、キャリーバッグ",
    "空気を入れるだけ！設営約1分半の簡単エアテント。初心者向けです。\n重量：7.2kg\n使用時サイズ：295×230×155(h)cm \n対応人数：3名\nインナーサイズ：210×210×125(h)cm\nセット内容：フレーム,フライシート,インナーシート,フロアシート",
    "空気を入れるだけ！設営約5分のPANEL SYSTEM搭載エアテント。２ルームの大型です。\n重量：15.4kg \n使用時サイズ：475×310×210(h)cm\n対応人数：4名\nインナーサイズ：280×210×185(h)cm\nセット内容：フレーム,フライシート,インナーシート,フロアシート",
    "シンプルでタフな構造。シルエットが逆四角錐形状です。開いて置くだけの簡単設営。\n重量：3.5kg \n使用時サイズ：350×350×248（h）mm\nセット内容：フレーム,キャリーバッグ,薪１束",
    "BBQ、焚き火、炭火調理がゆったり楽しめる頑丈グリル。\n重量：7.8kg\n使用時サイズ：約600×460×680(h)mm",
    "スタイリッシュなデザインのロケットパワーランタンです。ぬくもりのある暖色ライトは優しく周りを照らし出します。\nサイズ    13×11x25(h)cm",
"軽量で子供でも簡単に持ち運びが出来て、眩しくない優しい光が特徴。LEDで３段階に調整可能。充電式で７〜１４時間持続可能（光の強さによる）\n重量：0.5kg\nサイズ190x250(h)mm ",
"布ハンモックでおしゃれにリラックス。スタンド付きで機能性も抜群。木がなくても自立します。\n重量:9.5kg（ポール）\n耐荷重(約):80kg\n使用時サイズ：2720×950mm",
"快眠機能シュラフ・フィールドドリームの封筒型シュラフ。適用温度6度。3本のファスナーで上下分割や連結も可能。寝返りが楽にうてる大型サイズです \n重量：約3.2kg\nサイズ：220×85cm",
    "３つ口の延長コード。５メートルがちょうどいい長さでフォローします。\n長さ：５メートル\n防水ではありません。",
"ちょっとした食材を切りたい時にぴったりな調理セット。ペティナイフなので、フルーツを家から持ってきて、新鮮なままキャンプ場で切れます。\nセット内容：ペティナイフ、まな板、トング、おたま、フライ返し",
"ハイ・ロー2通りの使い方ができるフォールディングテーブル。合板とアルミ脚を使用しているので軽くて丈夫。\n重量：2.3kg\n使用時サイズ：600×450×600(ハイ・h)・270(ロー・h)mm",
"シンプルなデザインだからどんなシーンにも合うチェア。程よく傾いた背もたれでリラックスできます。\n重量：2.3kg\nサイズ：530x500x800(h)mm",
"指向性の高い風が送れるサーキュレーター。首振り機能も付いていて痒いところに手が届く一品。\n重量：2.2kg\nサイズ：240×220×320(h)mm",
"卓上サイズで軽量だから、あらゆるシーンで大活躍。ピンポイントで冷やせるのでソロキャンプに最適。テント内ならサーキュレーターとの合わせ技がオススメ\n重量：1kg\nサイズ：168x173x173(h)mm",
    "いざという時役立つポータブル電源。USB４本同時接続できるので一家みんなの携帯の充電がなくなっても安心です。LEDライトも搭載で便利。緊急用AC電源も付いています。\n重量：1.3kg\nサイズ：184x109x118(h)mm\n仕様：日本仕様の4Way出力：ACコンセント(2口):110V/60Hz 100W(瞬間最大150W)　DCポート(4口):12V/120W(瞬間最大15A/180W)　急速充電規格QC3.0(1口):最大18W(5V/2A、9V/1.5A、12V/1A) USB(3口)：5V/最大2.1A"]

  private let CellId = "cell"


    @IBOutlet weak var itemTable: UITableView!
    
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    self.overrideUserInterfaceStyle = .light
  }

  
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return photo.count
  }
  
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "RentalCell", for: indexPath)
      
    //画像
    let cellImageView = cell.contentView.viewWithTag(1) as! UIImageView
    let cellImage = UIImage(named: photo[indexPath.row])
    cellImageView.image = cellImage
    cellImageView.hero.id = "RentalImage"
    //商品名
    let cellNameLabel = cell.contentView.viewWithTag(2) as! UILabel
    cellNameLabel.text = itemName[indexPath.row]
    cellNameLabel.hero.id = "RentalName"
    //料金
    let cellPriceLabel = cell.contentView.viewWithTag(3) as! UILabel
    cellPriceLabel.text = itemPrice[indexPath.row]
    cellPriceLabel.hero.id = "RentalPrice"
    //説明文
    let cellDetailLabel = cell.contentView.viewWithTag(4) as! UILabel
    cellDetailLabel.text = itemDetail[indexPath.row]
    cellDetailLabel.hero.id = "RentalDetail"
      
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellId)
    return cell
}
  
  //セルの高さ調節
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return CGFloat(130)
  }

//セルがタッチされたら、詳細画面へ
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //RentalDetailViewControllerの略(REVC)
    let RDVC:RentalDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RDVC") as! RentalDetailViewController
    RDVC.image = UIImage(named: photo[indexPath.row])
    RDVC.name = self.itemName[indexPath.row]
    RDVC.price = self.itemPrice[indexPath.row]
    RDVC.detail = self.itemDetail[indexPath.row]
    RDVC.hero.isEnabled = false
    
    //self.navigationController?.pushViewController(RDVC, animated: true)
    self.present(RDVC, animated: true, completion: nil)
}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    itemTable.indexPathsForSelectedRows?.forEach{
        itemTable.deselectRow(at: $0, animated: true)
    }
}

func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.alpha = 0
    //セルのアニメーション表示　だんだん出てくる
    UIView.animate(withDuration: 0.2,
                   delay: 0.06 * Double(indexPath.row),
                   animations: {
                    cell.alpha = 1
                    }
                )
}

}

