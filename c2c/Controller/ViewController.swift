

import UIKit

class ViewController: UIViewController {

    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor(red: 57/255, green: 199/257, blue: 157/255, alpha: 1).cgColor
        emailTextField.frame.size.height = 45
        emailTextField.layer.cornerRadius = 23
        emailTextField.layer.masksToBounds = true
        emailTextField.placeholder = "   Email"
        
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor(red: 57/255, green: 199/257, blue: 157/255, alpha: 1).cgColor
        passwordTextField.layer.cornerRadius = 23
        passwordTextField.frame.size.height = 45
        passwordTextField.layer.masksToBounds = true
        passwordTextField.placeholder = "  Password"
        passwordTextField.isSecureTextEntry = true
      
        loginButton.layer.cornerRadius = 23
        
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
    }


    @IBAction func loginButton(_ sender: Any) {
        if emailTextField.text != "",passwordTextField.text != ""{
            //login
        }
    }
}

extension UIColor{
    class func acmGreen() -> UIColor{
        return UIColor(red: 57/255, green: 199/257, blue: 157/255, alpha: 1)
    }
}
