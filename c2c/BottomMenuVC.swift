//
//  BottomMenuVC.swift
//  c2c
//
//  Created by Tushar Singh on 14/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class BottomMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 

    @IBAction func downButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
