//
//  APIManager.swift
//  FlavorSafari
//
//  Created by Vikram Kunwar on 03/09/23.
//

import Foundation

class UserManager {
    static let shared = UserManager()

    private let userEmailKey = "userEmail"
    private let userPasswordKey = "userPassword"

    private init() {}

    // Sign up a user and store their email and password
    func signUp(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: userEmailKey)
        UserDefaults.standard.set(password, forKey: userPasswordKey)
    }

    // Log in a user by checking if the stored email and password match the input
    func logIn(email: String, password: String) -> Bool {
        guard let storedEmail = UserDefaults.standard.string(forKey: userEmailKey),
              let storedPassword = UserDefaults.standard.string(forKey: userPasswordKey)
        else {
            return false
        }

        return storedEmail == email && storedPassword == password
    }
}
