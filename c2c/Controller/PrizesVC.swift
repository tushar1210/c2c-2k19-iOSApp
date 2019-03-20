//
//  PrizesVC.swift
//  c2c
//
//  Created by Tushar Singh on 13/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class PrizesVC: UIViewController {

    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var UI: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var prizeLabel: UILabel!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var notification: UIImageView!
    @IBOutlet weak var innovativeSolution: UILabel!
    
    
    var ctr = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        menuIcon.isUserInteractionEnabled = true
        menuIcon.addGestureRecognizer(tapGesture)
        prizeLabel.textColor = .white
        winnerLabel.textColor = .white
        second.textColor = .white
        innovativeSolution.textColor = .white
        third.textColor = .white
        UI.textColor = .white
        bottomView.backgroundColor = UIColor.acmGreen()
 //bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        let ges = UITapGestureRecognizer(target: self, action: #selector(tap))
        notification.isUserInteractionEnabled = true
        notification.addGestureRecognizer(ges)
    }
    @objc func tap(){
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Alerts") as! AlertsVC
        present(vc, animated: true, completion: nil)
    }
    
    @objc func handleTap() {
        print("tapped")
        let childVC = storyboard!.instantiateViewController(withIdentifier: "BottomMenu")
        let segue = BottomCardSegue(identifier: nil, source: self, destination: childVC)
        prepare(for: segue, sender: nil)
        segue.perform()
        
    }
  
}


