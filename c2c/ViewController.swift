

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor(red: 57/255, green: 199/257, blue: 157/255, alpha: 1).cgColor
        emailTextField.frame.size.height = 45
        emailTextField.layer.cornerRadius = 23
        
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(red: 57/255, green: 199/257, blue: 157/255, alpha: 1).cgColor
        passwordTextField.layer.cornerRadius = 23
        passwordTextField.frame.size.height = 45
        
    }


    @IBAction func loginButton(_ sender: Any) {
    }
}

