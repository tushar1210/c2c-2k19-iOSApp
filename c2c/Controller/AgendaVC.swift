//
//  AgendaVC.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
class AgendaVC: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var contentTableView: UITableView!
    
    var startTimingArr = [String]()
    var finishTimingArr = [String]()
    var titleArr = [String]()
    var imgTypeArr = [String]()
    var dateArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        menuIcon.isUserInteractionEnabled = true
        menuIcon.addGestureRecognizer(tapGesture)
        bottomView.backgroundColor = UIColor.acmGreen()
        bottomView.layer.cornerRadius = 20
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
    }
    
    func get(){
        let ref = Database.database().reference()
        ref.observe(.value) { (data) in
            let json = JSON(data.value)
            
            for i in 0...json.count+2{
                self.titleArr.append(json["agendas"]["agendasList"][i]["agendaTitle"].stringValue)
                self.startTimingArr.append(json["agendas"]["agendasList"][i]["startTime"].stringValue)
                self.finishTimingArr.append(json["agendas"]["agendasList"][i]["endTime"].stringValue)
                self.imgTypeArr.append(json["agendas"]["agendasList"][i]["type"].stringValue)
                
                
            }
            print("Count",json.count)
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

extension AgendaVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(titleArr.count)
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTableView.dequeueReusableCell(withIdentifier: "agenda") as! AgendaTableViewCell
        cell.isUserInteractionEnabled = false
        cell.timingLabel.textColor = .white
        cell.typeLabel.textColor = .white
        cell.typeLabel.text = titleArr[indexPath.section]
        cell.timingLabel.text = startTimingArr[indexPath.section]+" - "+finishTimingArr[indexPath.section]
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
