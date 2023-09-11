//
//  ForegtPasswordVC.swift
//  FlavorSafari
//
//  Created by Vikram Kunwar on 02/09/23.
//

import UIKit
import MessageUI
class ForegtPasswordVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var foregetPasswordMailTextField: UITextField!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let cornerRadius: CGFloat = 20
        foregetPasswordMailTextField.applyCornerRadius(cornerRadius)
        
        
        let gradientColor = CAGradientLayer()
        gradientColor.frame = continueBtn.bounds
        gradientColor.colors = [UIColor(hex: "#416DDB").cgColor, UIColor(hex: "#21366E").cgColor]
        gradientColor.startPoint = CGPoint(x: 0.4, y: 0.5)
        gradientColor.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientColor.cornerRadius = continueBtn.layer.cornerRadius
        gradientColor.masksToBounds = true
        continueBtn.layer.addSublayer(gradientColor)
        
        

        

        
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        
        guard let email = foregetPasswordMailTextField.text, !email.isEmpty else {
                    showAlert(title: "Error", message: "Please enter your email address.")
                    return
                }

                if !isValidEmail(email) {
                    showAlert(title: "Error", message: "Please enter a valid email address.")
                    return
                }

                sendPasswordResetEmail(email)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }

        func sendPasswordResetEmail(_ email: String) {
            let mailComposer = MFMailComposeViewController()

                if MFMailComposeViewController.canSendMail() {
                    mailComposer.mailComposeDelegate = self
                    mailComposer.setToRecipients([email])
                    mailComposer.setSubject("Password Reset")
                
                    let body = "Please click on the provided link to reset your password."
                    mailComposer.setMessageBody(body, isHTML: false)
                
                    present(mailComposer, animated: true, completion: nil)
                } else {
                    showAlert(title: "Error", message: "Could not send password reset email. Please check your email configuration.")
                }
        }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if let error = error {
                showAlert(title: "Error", message: "An error occurred while attempting to send the password reset email: \(error.localizedDescription)")
            }
            controller.dismiss(animated: true, completion: nil)
        }
    

    
}

extension ForegtPasswordVC {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
