//
//  BottomMenuVC.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class BottomMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var contentTable: UITableView!
    
    var labelArr = ["Agenda","Prizes","Food Coupons","Sponsors","About","FAQs","Logout"]
    var whiteImages = ["heartWhite","trophyWhite","couponsWhite","SponsorsWhite","AboutWhite","FAQ White","logoutWhite"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTable.delegate = self
        contentTable.dataSource = self
        contentTable.backgroundColor = UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        contentTable.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    

 

    @IBAction func downButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BottomMenuVC{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BottomTableCell
        cell.typeLabel.text = labelArr[indexPath.row]
        cell.typeLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.75)
        cell.typeImage.image = UIImage(named: whiteImages[indexPath.row])
        cell.backgroundColor = UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
