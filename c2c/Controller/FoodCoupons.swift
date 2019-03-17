//
//  FoodCoupons.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

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
    
    var status = false
    var typeArr = [String]()
    var statusArr = [Bool]()
    var timingArr = [String]()
    var tokenArr = [String]()
    var userDict=[String:JSON]()
    var connected = false
    let connect: ChirpConnect = ChirpConnect(appKey: "BC9BBD9E355CA7CAF83DD408e", andSecret: "8A9C04Ad084fBb21db1f478aE90ecCDfE3872ccFeD43A52E9b")!
    var str = "token"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        menuIcon.isUserInteractionEnabled = true
        menuIcon.addGestureRecognizer(tapGesture)
        bottomView.backgroundColor = UIColor.acmGreen()
        bottomView.layer.cornerRadius = 20
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        somethingWrong.titleLabel?.textColor = UIColor.acmGreen()
        get()
        
    }
    
    func get(){
        let ref = Database.database().reference()
        ref.observe(.value) { (snap) in
            
            print("SNAP",snap)
            var data = JSON(snap.value)
            var k=0
            print("COunt", data)
            for i in 0...data["sannables"]["list"].count-1{
                self.typeArr.append(data["sannables"]["list"][i]["type"].stringValue)
                self.tokenArr.append(data["sannables"]["list"][i]["key"].stringValue)
                self.timingArr.append(data["sannables"]["list"][i]["timings"].stringValue)
                print("TYPE", self.typeArr[i])
            }
            for (key,subJson):(String,JSON) in data["sannables"]{
                if key != "sannables"{
                    self.userDict[key] = data["sannables"][key]["user"]
                    
                }

            }
            
            self.contentTableView.reloadData()
        }
    }
    
    @objc func handleTap() {
        print("tapped")
        let childVC = storyboard!.instantiateViewController(withIdentifier: "BottomMenu")
        let segue = BottomCardSegue(identifier: nil, source: self, destination: childVC)
        prepare(for: segue, sender: nil)
        segue.perform()
        
    }


    @IBAction func micButton(_ sender: Any) {
        
        send()
        recieve()
        connect.stop {
            print("Stopprd")
        }
    }
    
    @IBAction func somethingWrong(_ sender: Any) {
    
    }
}


extension FoodCouponsVC{
    func numberOfSections(in tableView: UITableView) -> Int {
        
       return typeArr.count
        
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
        cell.backgroundColor=UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        cell.layer.cornerRadius = 10
        cell.typeLabel.text = typeArr[indexPath.section]
        cell.typeLabel.textColor = .white
        cell.timingLabel.text = timingArr[indexPath.section]
        cell.statusLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.75)
        cell.timingLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.70)
        
        cell.selectionStyle = .none
      
        if status{
            cell.statusLabel.text = "Redeemed"
            cell.isUserInteractionEnabled = false
        }else{
            cell.statusLabel.text = "Redeem"
            cell.isUserInteractionEnabled = true
        }
        cell.sideView.backgroundColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha:173/255)
        cell.statusLabel.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha: 1)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = contentTableView.cellForRow(at: indexPath) as! FoodTableViewCell
        if !status{
            cell.sideView.backgroundColor = UIColor.acmGreen()
            cell.statusLabel.textColor = .white
            
        }
       
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = contentTableView.cellForRow(at: indexPath) as! FoodTableViewCell
        if !status{
            cell.sideView.backgroundColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha:173/255)
            cell.statusLabel.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha: 1)
            
        }
        else{
            cell.sideView.backgroundColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 173/255)
            cell.statusLabel.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha: 1)
            
        }
    }
    
    
}
extension FoodCouponsVC{
    
    func start(){
        connect.setConfigFromNetworkWithCompletion { (error) in
            if error == nil{

                self.connect.start()
                

            }
            else{
                print("ERROR  ",error)
            }
        }
    }
    func send(){
        let time = connect.duration(forPayloadLength: 3)
        start()
        print(str)
        print(connect.channelCount)
        let data = Data(str.utf8)
        connect.send(data)
    }

    func recieve(){
        connect.receivedBlock = {
            (data : Data?, channel: UInt?) -> () in
            if let data = data {
                print(String(data: data, encoding: .ascii)!)
                self.str = String(data: data, encoding: .ascii) ?? "NIL"
                return;
            }
        }
    }
    
   
}

