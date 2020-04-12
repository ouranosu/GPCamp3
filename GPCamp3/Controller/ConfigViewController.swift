//
//  ConfigViewController.swift
//  GPCamp3
//
//  Created by work on 2019/12/15.
//  Copyright © 2019 Masahiro Okura. All rights reserved.
//

import UIKit
import PopupDialog
import MessageUI

class ConfigViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var configTable: UITableView!
    
    fileprivate let labelArray = ["利用規約", "プライバシーポリシー", "アプリに関するお問い合わせ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ダークモード回避
        self.overrideUserInterfaceStyle = .light
        callQuestionnaireDialog()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ConfigCell", for: indexPath)
        let cellLabel = cell.contentView.viewWithTag(1) as! UILabel
        cellLabel.text = labelArray[indexPath.row]
        
        return cell
        
    }
    
    //選択時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: //利用規約
            let termsStoryBoard = UIStoryboard(name: "Terms", bundle: nil)
            let termsVC = termsStoryBoard.instantiateViewController(identifier: "Terms") as! TermsViewController
            self.present(termsVC, animated: true, completion: nil)
            break
        case 1: //プライバシーポリシー
            let policyStoryBoard = UIStoryboard(name: "PrivacyPolicy", bundle: nil)
            let policyVC = policyStoryBoard.instantiateViewController(identifier: "PrivacyPolicy") as! PrivacyPolicyViewController
            self.present(policyVC, animated: true, completion: nil)
            break
        case 2: //アプリの問い合わせ
            //メーラーを起動して、宛先、件名を標準入力
            let mailViewController: MFMailComposeViewController = callMailer()
            self.present(mailViewController, animated: true, completion: nil)
            break
        default:
            return
        }
        configTable.deselectRow(at: indexPath, animated: true)
    }
    
    //セル高さ調整
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    */
    
    
    //アンケート
    func callQuestionnaireDialog(){
        
        let title = "アンケートのお願い"
        let message = "サービス向上のためにご協力をお願いいたします。アンケートに答えますか？"
        let image = UIImage(named: "questionnaire")
        
        let popUp = PopupDialog(title: title, message: message, image: image)
        let button1 = CancelButton(title: "Cancel", height: 60){
            return
        }
        
        let button2 = DefaultButton(title: "OK", height: 60){
            let WebViewController = self.storyboard?.instantiateViewController(identifier: "Questionnair")
            self.present(WebViewController!, animated: true, completion: nil)
        }
        
        popUp.addButtons([button1, button2])
        
        self.present(popUp, animated: true, completion: nil)
        
    }
    
    //メーラー起動
    func callMailer() -> MFMailComposeViewController {
        if MFMailComposeViewController.canSendMail() == false {
            let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "メールを送信できませんでした。", preferredStyle: UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) -> Void in
                return
            })
            
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
        
        let mailViewController = MFMailComposeViewController()
        let toRecipients: [String] = ["okstorenoid@gmail.com"]
        let subject: String = "GPCamp　問い合わせ"
        
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject(subject)
        mailViewController.setToRecipients(toRecipients)
        mailViewController.setMessageBody("ご自由にご記入ください", isHTML: false)
        return mailViewController
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            makeAlert(alertNum: 0)
            break
        case .saved:
            makeAlert(alertNum: 1)
            break
        case .sent:
            makeAlert(alertNum: 2)
            break
        case .failed:
            makeAlert(alertNum: 3)
            break
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    //alert
    func makeAlert(alertNum: Int) -> Void {
        
        let title: String = "アラート表示"
        var message: String!
        
        switch alertNum {
        case 0:
            message = "キャンセルしました"
            break
        case 1:
            message = "保存しました"
            break
        case 2:
            message = "送信しました"
            break
        case 3:
            message = "送信できませんでした。\n通信状況を確認してください。"
            break
        default:
            break
        }
        
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            return
        })
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
