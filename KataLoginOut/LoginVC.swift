//
//  File.swift
//  KataLoginOut
//
//  Created by Miguel Hernández Jaso on 24/01/2019.
//  Copyright © 2019 Miguel Hernández Jaso. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!

    // MARK: Actions

    @IBAction func loginWasTapped(_ sender: UIButton) {
        let result = self.login(withUser: userName.text, password: password.text)
        var message = ""
        switch result {
        case .success(let result):
            guard let resultMessage = result as? String else { assertionFailure("Result must be a string"); return }
            message = resultMessage
        case .failure(let error):
            message = error
        }

        let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: Business logic

    func login(withUser user: String?, password: String?) -> Result {
        if user == "admin" && password == "admin" {
            return Result.success(result: "OK")
        }
        return Result.failure(error: "A tomar por culo")
    }

    enum Result {
        case success(result: Any)
        case failure(error: String)
    }
}
