//
//  SignInVC.swift
//  FlavorSafari
//
//  Created by Vikram Kunwar on 02/09/23.
//

import UIKit
import DropDown

class SignInVC: UIViewController {
    
    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var phonetextField: UITextField!
    @IBOutlet weak var mailtextField: UITextField!
    @IBOutlet weak var passwordtextField4: UITextField!
    @IBOutlet weak var confirmPasswordtextField: UITextField!
    @IBOutlet weak var referraltextField: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    @IBOutlet weak var dropDownView : UIView!
    
    @IBOutlet weak var dropTitle : UILabel!
    
    
    var iconClick = false
    let imageIcon = UIImageView()
    
    
    @IBOutlet weak var checkMar: UIImageView!
    
    let countryList = countries
    
    var isCheck = false
    
    let dropDown = DropDown()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageIcon.image = UIImage(systemName: "eye")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        imageIcon.tintColor = .black
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye")!.size.width, height: UIImage(systemName: "eye")!.size.height)
        
        imageIcon.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye")!.size.width, height: UIImage(systemName: "eye")!.size.height)
        

        
        passwordtextField4.rightView = contentView
        passwordtextField4.rightViewMode = .always
        
  
       
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imagedtapped(tapGesture:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGesture)
        
        
        
        let cornerRadius: CGFloat = 20 // Set your desired corner radius value
        
        nametextField.applyCornerRadius(cornerRadius)
        phonetextField.applyCornerRadius(cornerRadius)
        mailtextField.applyCornerRadius(cornerRadius)
        passwordtextField4.applyCornerRadius(cornerRadius)
        confirmPasswordtextField.applyCornerRadius(cornerRadius)
        referraltextField.applyCornerRadius(cornerRadius)
        
        let gradientColor = CAGradientLayer()
        gradientColor.frame = signUpBtn.bounds
        gradientColor.colors = [UIColor(hex: "#416DDB").cgColor, UIColor(hex: "#21366E").cgColor]
        gradientColor.startPoint = CGPoint(x: 0.4, y: 0.5)
        gradientColor.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientColor.cornerRadius = signUpBtn.layer.cornerRadius
        gradientColor.masksToBounds = true
        signUpBtn.layer.addSublayer(gradientColor)
        
        dropTitle.text = "Select Your Country"
        
        dropDownView.layer.borderColor = UIColor.black.cgColor
        
        dropDown.anchorView = dropDownView
        dropDown.dataSource = countryList
        
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.dropTitle.text = countryList[index]

        }
        
        
        
    }
    
    @objc func imagedtapped(tapGesture : UITapGestureRecognizer){
        let tappedImage = tapGesture.view as! UIImageView
        
        if iconClick
        {
            iconClick = false
            tappedImage.image = UIImage(systemName: "eye")
            tappedImage.tintColor = .black
            passwordtextField4.isSecureTextEntry = false
        }
        else
        {
            iconClick = true
            tappedImage.image = UIImage(systemName: "eye.slash")
            tappedImage.tintColor = .black

            passwordtextField4.isSecureTextEntry = true
        }
    }
    
    @IBAction func checkMarkClicked(_sender: UIButton){
        
        if isCheck == false
        {
            isCheck = true
            checkMar.image = UIImage(named: "clickImageTick")
        }
        else
        {
            isCheck = false
            checkMar.image = UIImage(named: "clickImage")
        }
        
        
        
    }
    
    @IBAction func dropDownShow(_ sender: UIButton){
        dropDown.show()
        
        
    }
    
    @IBAction func signUpBtnClicked(_ sender:UIButton){
        
        let email = mailtextField.text ?? ""
            let password = passwordtextField4.text ?? ""
            let confirmPassword = confirmPasswordtextField.text ?? ""
        
             if email.isEmpty || password.isEmpty {
                showAlert(title: "Error", message: "Please enter your email and password.")
                return
            }

            // Add validation here to check if the entered data is valid
            if password != confirmPassword {
                showAlert(title: "Error", message: "Password and confirm password do not match.")
                return
            }

            // Sign up the user
            UserManager.shared.signUp(email: email, password: password)
            showAlert(title: "SignUp Successful", message: "You have successfully registered.")
        
          
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
