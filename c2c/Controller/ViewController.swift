

import UIKit
import Firebase
import SwiftyJSON
class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    var json = JSON()
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
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
        passwordTextField.clearsOnInsertion = false
        emailTextField.clearsOnInsertion = false
        
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
    }
    
    func get(){
        let ref = Database.database().reference().child("users")
        ref.observe(.value) { (data) in
            self.json = JSON(data.value)

        }
    }
    
    func validate(email:String,pass:String){
        for (key,subJson):(String,JSON) in self.json{
            print(json[key]["email"].stringValue)
            if email == json[key]["email"].stringValue && pass == json[key]["password"].stringValue{
                performSegue(withIdentifier: "go1", sender: nil)
                
            }else{
                passwordTextField.text = ""
                emailTextField.isHighlighted=true
                passwordTextField.placeholder = "Wrong Credentials"
            }
        }
    }


    @IBAction func loginButton(_ sender: Any) {
        if emailTextField.text != "",passwordTextField.text != ""{
            validate(email: emailTextField.text!, pass: passwordTextField.text!)
        }
    }
}

extension UIColor{
    class func acmGreen() -> UIColor{
        return UIColor(red: 57/255, green: 199/257, blue: 157/255, alpha: 1)
    }
    
    
}
