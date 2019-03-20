//
//  SponsorsVC.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import Kingfisher
class SponsorsVC: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var notification: UIImageView!
    @IBOutlet weak var contentTableView: UITableView!
    
    var imageArr = [URL]()
    var json = JSON()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        menuIcon.isUserInteractionEnabled = true
        menuIcon.addGestureRecognizer(tapGesture)
        bottomView.backgroundColor = UIColor.acmGreen()
       // bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        let ges = UITapGestureRecognizer(target: self, action: #selector(tap))
        notification.isUserInteractionEnabled = true
        notification.addGestureRecognizer(ges)
        get()
        // Do any additional setup after loading the view.
    }
    @objc func tap(){
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Alerts") as! AlertsVC
        present(vc, animated: true, completion: nil)
    }
    
    func get(){
        let ref = Database.database().reference().child("sponsors")
        ref.observe(.value) { (data) in
            self.json = JSON(data.value)
            for (key,_):(String,JSON) in self.json{
                self.imageArr.append(URL(string:self.json[key].stringValue)!)
                
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

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension SponsorsVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return imageArr.count

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTableView.dequeueReusableCell(withIdentifier: "sponsor") as! SponsorTableViewCell
        cell.sponsor.kf.setImage(with: imageArr[indexPath.section])
        cell.backgroundColor = .clear
        cell.isUserInteractionEnabled = false
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
//        v.frame = CGRect(x: 0, y: 0, width: contentTableView.frame.width, height: 150)
        return v
    }
    
}
