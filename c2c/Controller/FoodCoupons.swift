//
//  FoodCoupons.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//
var currentUser = "tushar1test@aws.com"
var off=true

import UIKit
import ChirpConnect
import Firebase
import SwiftyJSON

class FoodCouponsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var somethingWrong: UIButton!
    @IBOutlet weak var notification: UIImageView!
    
    var k = 0
    var json = JSON()
    var itemList = [String]()
    var timingArrStart = [String]()
    var timingArrEnd = [String]()
    var tokenArr = [String]()
    var date = [String]()
    var attendance = [String:[String]]()
    var keyArr = [String]()
    let connect: ChirpConnect = ChirpConnect(appKey: "BC9BBD9E355CA7CAF83DD408e", andSecret: "8A9C04Ad084fBb21db1f478aE90ecCDfE3872ccFeD43A52E9b")!
    var token = ""
    var tokenRecieved = ""
    var j=0
    var userArr=[String]()
    var currentType=""
    var isPresent = true
    var reedeemedArr = [String]()
    var currentT = String()
    var typeArr = [String]()
    var status = ""
    var userDict = [String:[String]]()
    var ip = [Int]()
    
    override func viewDidLoad() {
        
        get()
        super.viewDidLoad()
        contentTableView.allowsMultipleSelection = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        menuIcon.isUserInteractionEnabled = true
        menuIcon.addGestureRecognizer(tapGesture)
        bottomView.backgroundColor = UIColor.acmGreen()
        //bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        somethingWrong.titleLabel?.textColor = UIColor.acmGreen()
        let ges = UITapGestureRecognizer(target: self, action: #selector(tap))
        notification.isUserInteractionEnabled = true
        notification.addGestureRecognizer(ges)
        
        
    }
    @objc func tap(){
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Alerts") as! AlertsVC
        present(vc, animated: true, completion: nil)
    }
    
    
    
    @objc func handleTap() {
        let childVC = storyboard!.instantiateViewController(withIdentifier: "BottomMenu")
        let segue = BottomCardSegue(identifier: nil, source: self, destination: childVC)
        prepare(for: segue, sender: nil)
        connect.stop()
        segue.perform()
        
    }
    
    
    
    func get(){
        attendance.removeAll()
        userArr.removeAll()
        timingArrEnd.removeAll()
        timingArrStart.removeAll()
        itemList.removeAll()
        tokenArr.removeAll()
        date.removeAll()
        typeArr.removeAll()
        
        let ref = Database.database().reference().child("scannables")
        ref.observe(.value) { (snap) in
            self.json = JSON(snap.value)
            for i in 0...self.json["list"]["scannableList"].count-1{
                self.itemList.append(self.json["list"]["scannableList"][i]["scannableTitle"].stringValue)
                self.timingArrStart.append(self.json["list"]["scannableList"][i]["scannableStartTime"].stringValue)
                self.timingArrEnd.append(self.json["list"]["scannableList"][i]["scannableEndTime"].stringValue)
                self.tokenArr.append(self.json["list"]["scannableList"][i]["scannableKey"].stringValue)
                self.date.append(self.json["list"]["scannableList"][i]["scannableDate"].stringValue)
                self.typeArr.append(self.json["list"]["scannableList"][i]["scannableValue"].stringValue)
                
            }
            for (key,_):(String,JSON) in self.json["attendance"]{
                self.keyArr.append(key)
                self.userArr.removeAll()
                for i in 0...self.json["attendance"][key]["couponsUserList"].count-1{
                    self.userArr.append(self.json["attendance"][key]["couponsUserList"][i].stringValue)
                    self.attendance[key] = self.userArr
                }
            }
            self.check()
            self.contentTableView.reloadData()
        }
    }

    func check(){
        
        for i in 0...keyArr.count-1{
                for j in 0...attendance[keyArr[i]]!.count-1{
                    if currentUser != attendance[keyArr[i]]![j]{
                        isPresent = false
                    }
                    else{
                        isPresent = true
                    }
                }
            if isPresent{
                reedeemedArr.append(keyArr[i])
            }
        }
    }

    @IBAction func micButton(_ sender: Any) {
        
        //if off && currentType != "" {
            start()
            
       // }
            recieve()
    }
    
    @IBAction func somethingWrong(_ sender: Any) {
    
        performSegue(withIdentifier: "go9", sender: nil)
    }
}

extension FoodCouponsVC{
    
    func start(){
        off=false
        connect.setConfigFromNetworkWithCompletion { (error) in
            if error == nil{
                self.connect.start()
            }
            else{
                print("ERROR  ",error!)
            }
        }
    }
    func recieve(){
        if currentType != ""{
            connect.receivedBlock = {
                (data : Data?, channel: UInt?) -> () in
                if let data = data {
                    self.tokenRecieved = String(data: data, encoding: .ascii)!
                    self.validate()
                    return;
                }
                else{
                    self.tokenRecieved=""
                }
                
            }
        }
    }
    
    func validate(){

        if tokenRecieved != "" && token != "" && currentT != ""{
            var response = ""
            for i in 0...attendance[currentT]!.count-1{
                if currentUser != attendance[currentT]![i] && tokenRecieved==token{
                    status="ok"
                    response = "Sucessfully Redeemed"
                    let alert = UIAlertController(title: "Response", message: response, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else{
                    status=""
                    response = "Item Already Redeemed or Wrong Token"
                    let alert = UIAlertController(title: "Response", message: response, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            if status == "ok"{
                attendance[currentT]!.append(currentUser)
                let ref = Database.database().reference().child("scannables").child("attendance").child(currentT).child("couponsUserList")
                ref.setValue(attendance[currentT])
                attendance.removeAll()
                userArr.removeAll()
                timingArrEnd.removeAll()
                timingArrStart.removeAll()
                itemList.removeAll()
                tokenArr.removeAll()
                date.removeAll()
                typeArr.removeAll()
                
            }
        }
    }
}

extension FoodCouponsVC{
    func numberOfSections(in tableView: UITableView) -> Int {

        return itemList.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell
        cell.typeLabel.textColor = .white
        cell.sideView.backgroundColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
        cell.backgroundColor=UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        cell.layer.cornerRadius = 10
        cell.statusLabel.textColor = UIColor(red: 77/255, green: 74/255, blue: 74/255, alpha: 1)
        cell.timingLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.70)
        cell.selectionStyle = .none
        if json.count>0{
            cell.typeLabel.text = itemList[indexPath.section]
            cell.timingLabel.text = timingArrStart[indexPath.section]+" - "+timingArrEnd[indexPath.section]
            }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index",indexPath.section)
        let cell = contentTableView.cellForRow(at: indexPath) as! FoodTableViewCell
        if k==0{
            
        k+=1
        token = tokenArr[indexPath.section]
        currentType=itemList[indexPath.section]
        cell.sideView.backgroundColor = UIColor.acmGreen()
        currentT=typeArr[indexPath.section]
        cell.statusLabel.textColor = .white
        if reedeemedArr.contains(currentT){
            cell.statusLabel.text = "Redeemed"
            cell.sideView.backgroundColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
            cell.isSelected = false
            cell.isUserInteractionEnabled = false
            cell.statusLabel.textColor = UIColor(red: 77/255, green: 74/255, blue: 74/255, alpha: 1)
            currentT=""
        }
        else{
            cell.statusLabel.text = "Redeem"
            cell.statusLabel.textColor = .white
            }
            
        }else{
            k=0
            cell.sideView.backgroundColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
            cell.statusLabel.textColor = UIColor(red: 77/255, green: 74/255, blue: 74/255, alpha: 1)
            cell.statusLabel.text = ""
            currentType = ""
            token = ""
            currentT=""
            contentTableView.reloadData()
        }
        print(currentT)

    }
    
    
}
    


