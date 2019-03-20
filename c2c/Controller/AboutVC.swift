//
//  AboutVC.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var notification: UIImageView!
    @IBOutlet weak var c2c: UITextView!
    @IBOutlet weak var acm: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        c2c.text = "A thrilling tech sprint awaited by numerous innovators, Code2Create witnesses a plethora of skill sets. Code2Create is all about designing, building and creating; a place where graphic designers, software developers, app developers, and web developers collaborate intensively on projects. Code2Create'18 saw more than 500 participants. The judges were renowned experts in their respective fields. Participants from across the country indulge in 36 hours of intense brainstorming, designing, creating and testing, along with some engaging and very enjoyable side quests. Code2Create is ACM-VIT’s flagship event and one of the grandest annual events hosted in VIT."
        acm.text = "Right from its inception in 2009, the ACM VIT Student Chapter has been organizing and conducting successful technical and professional development events. It hosted Compute 2013, the 6th ACM India Computing Convention from 22nd to 24th August 2013, as well as the first All India ACM Chapters Meet on 24th August 2013. It has credentials in web/mobile applications development and machine learning. The websites All About VIT and VIT Cab Share are some of the treasured creations of its core members. Technology is its cause and education its objective"
        
        acm.textColor = .white
        c2c.textColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        menuIcon.isUserInteractionEnabled = true
        menuIcon.addGestureRecognizer(tapGesture)
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
