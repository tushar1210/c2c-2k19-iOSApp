//
//  AlertsVC.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class AlertsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var contentTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentTableView.delegate = self
        contentTableView.dataSource = self
        menuIcon.isUserInteractionEnabled = true
        menuIcon.addGestureRecognizer(tapGesture)
        bottomView.backgroundColor = UIColor.acmGreen()
        bottomView.layer.cornerRadius = 20
        contentTableView.backgroundColor = .clear
        contentTableView.allowsSelection=false
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
        return 2
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
        cell.timeLabel.text = "2:00 PM"
        cell.notificationHeading.text = "Notification"
        cell.notificationBody.text="Snacks Served ! "
        cell.notificationBody.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
