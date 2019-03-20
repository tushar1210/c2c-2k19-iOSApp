//
//  AlertsVC.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class AlertsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var contentTableView: UITableView!
    
    var timeArr = [String]()
    var bodyArr = [String]()
    var headArr = [String]()

    var json = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentTableView.delegate = self
        contentTableView.dataSource = self
        menuIcon.isUserInteractionEnabled = true
        menuIcon.addGestureRecognizer(tapGesture)
        bottomView.backgroundColor = UIColor.acmGreen()
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        contentTableView.backgroundColor = .clear
        contentTableView.allowsSelection=false
    }
    
    func get(){
        timeArr.removeAll()
        bodyArr.removeAll()
        headArr.removeAll()
        let ref = Database.database().reference().child("notification")
        ref.observe(.value) { (snap) in
            self.json = JSON(snap.value)
            if self.json.count>1{
                for i in 0...self.json.count-1{
                    self.timeArr.append(self.json[i]["time"].stringValue)
                    self.bodyArr.append(self.json[i]["message"].stringValue)
                    self.headArr.append(self.json[i]["title"].stringValue)
                }
            }
            else{
                self.timeArr.append(self.json[0]["time"].stringValue)
                self.bodyArr.append(self.json[0]["message"].stringValue)
                self.headArr.append(self.json[0]["title"].stringValue)
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
}

extension AlertsVC{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        
        v.backgroundColor = .clear
        return v
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTableView.dequeueReusableCell(withIdentifier: "alertCell", for: indexPath) as! AlertCell
        cell.backgroundColor = UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        cell.timeLabel.text = timeArr[indexPath.section]
        cell.notificationHeading.text = headArr[indexPath.section]
        cell.notificationBody.text=bodyArr[indexPath.section]
        cell.notificationBody.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
