//
//  LoginVC.swift
//  FlavorSafari
//
//  Created by Vikram Kunwar on 02/09/23.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var mailTextF: UITextField!
    @IBOutlet weak var passwordTextF: UITextField!
    
    @IBOutlet weak var loginNowBtn: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cornerRadius: CGFloat = 20
        mailTextF.applyCornerRadius(cornerRadius)
        passwordTextF.applyCornerRadius(cornerRadius)
        
        let gradientColor = CAGradientLayer()
        gradientColor.frame = loginNowBtn.bounds
        gradientColor.colors = [UIColor(hex: "#416DDB").cgColor, UIColor(hex: "#21366E").cgColor]
        gradientColor.startPoint = CGPoint(x: 0.4, y: 0.5)
        gradientColor.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientColor.cornerRadius = loginNowBtn.layer.cornerRadius
        gradientColor.masksToBounds = true
        loginNowBtn.layer.addSublayer(gradientColor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
            // Reset the title when the view appears
            self.title = "Login"
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the back button when leaving this view controller
        self.navigationItem.setHidesBackButton(false, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Replace the back button with a custom button that navigates to UserPortalVC
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backToUserPortal))
        self.navigationItem.leftBarButtonItem = backButton
    }

    @objc func backToUserPortal() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let userPortalVC = storyboard.instantiateViewController(withIdentifier: "UserPortalVC") as! UserPortalVC
        self.navigationController?.pushViewController(userPortalVC, animated: true)
    }

    
    
    
    @IBAction func foregetBtnClicked(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForegtPasswordVC")
        
        vc?.title = "ForegtPassword"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    @IBAction func loginBtnClick(_ sender: UIButton){
        let email = mailTextF.text ?? ""
            let password = passwordTextF.text ?? ""

            // Log in the user
            // Check if email and password are empty
            if email.isEmpty || password.isEmpty {
                showAlert(title: "Login Failed", message: "Please enter your email and password")
            } else {
                // Log in the user
                if UserManager.shared.logIn(email: email, password: password) {
                    // Login successful, navigate to the next screen
                    // You can perform the navigation code here
                    let storyboard = UIStoryboard(name: "Login", bundle: nil)
                    let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
                    
                    self.navigationController?.setNavigationBarHidden(false, animated: false) // Show navigation bar
                    
                    // Store flag in user defaults
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    
                    self.navigationController?.pushViewController(dashboardVC, animated: true)
                } else {
                    showAlert(title: "Login Failed", message: "Invalid email or password")
                }
            }
 
        
    }
    
    
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
