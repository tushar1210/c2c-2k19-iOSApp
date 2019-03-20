//
//  someThingWrongVC.swift
//  c2c
//
//  Created by Tushar Singh on 20/03/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class someThingWrongVC: UIViewController {

    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        text.textColor = .white
        backButton.setTitleColor(.white, for: .normal)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
