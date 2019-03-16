//
//  FoodCoupons.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class FoodCouponsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var contentTableView: UITableView!
    var status = false
    var typeArr = [String]()
    var statusArr = [Bool]()
    var timingArr = [String]()
    
    
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
    }
    
    
    
    @objc func handleTap() {
        print("tapped")
        let childVC = storyboard!.instantiateViewController(withIdentifier: "BottomMenu")
        let segue = BottomCardSegue(identifier: nil, source: self, destination: childVC)
        prepare(for: segue, sender: nil)
        segue.perform()
        
    }


}


extension FoodCouponsVC{
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell
        cell.backgroundColor=UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        cell.layer.cornerRadius = 10
        cell.typeLabel.text = "Lunch"
        cell.typeLabel.textColor = .white
        cell.timingLabel.text = "10-2"
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
