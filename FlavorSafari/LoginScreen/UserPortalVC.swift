//
//  UserPortalVC.swift
//  FlavorSafari
//
//  Created by Vikram Kunwar on 02/09/23.
//

import UIKit

class UserPortalVC: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var splashImage: UIImageView!
    
    
    private var isAnimating = true
    private var scrollTimer: Timer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientColor = CAGradientLayer()
        gradientColor.frame = loginBtn.bounds
        gradientColor.frame = registerBtn.bounds

        gradientColor.colors = [UIColor(hex: "#416DDB").cgColor, UIColor(hex: "#21366E").cgColor]
        gradientColor.startPoint = CGPoint(x: 0.4, y: 0.5)
        gradientColor.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientColor.cornerRadius = loginBtn.layer.cornerRadius
        gradientColor.cornerRadius = registerBtn.layer.cornerRadius

        gradientColor.masksToBounds = true
        loginBtn.layer.addSublayer(gradientColor)
        registerBtn.layer.addSublayer(gradientColor)
        
        let gradientColorr = CAGradientLayer()
        gradientColorr.frame = loginBtn.bounds

        gradientColorr.colors = [UIColor(hex: "#416DDB").cgColor, UIColor(hex: "#21366E").cgColor]
        gradientColorr.startPoint = CGPoint(x: 0.4, y: 0.5)
        gradientColorr.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientColorr.cornerRadius = loginBtn.layer.cornerRadius

        gradientColorr.masksToBounds = true
        loginBtn.layer.addSublayer(gradientColorr)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
            if isLoggedIn {
                navigateToDashboard()
            }
        
        
        
        if isAnimating {
            // Set initial transform for offscreen animation
            splashImage.transform = CGAffineTransform(translationX: 0, y: -splashImage.frame.height)

            // Animate coffeeCupImg into view with spring effect and limit to 1 bounce
            UIView.animate(withDuration: 5.0, delay: 0, usingSpringWithDamping: 3.0, initialSpringVelocity: 3.0, options: []) {
                self.splashImage.transform = .identity
            } completion: { _ in
                // Animation completed, set isAnimating to false
//                  self.isAnimating = false
                
                
                // Set a timer to stop the animation after 2 seconds
                self.scrollTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
//                      self.stopAnimation()
                }
            }

            // Animate coffeeLbl with Hero-like animation
            
            
            
        }


        
    }
    
    
    
    
   
    
    @IBAction func logBtnClicked(_sender : UIButton){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        
        vc?.title = "Login"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    
    @IBAction func registerClicked(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignInVC")
        
        vc?.title = "SignUp"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    private func navigateToDashboard() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
        self.navigationController?.pushViewController(dashboardVC, animated: false)
    }
    
    
    
    

    
}
