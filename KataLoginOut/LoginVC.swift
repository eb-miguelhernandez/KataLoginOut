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
    @IBOutlet weak var loginPanel: UIView! {
        didSet {
            loginPanel.isHidden = false
        }
    }
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var logoutPanel: UIView!{
        didSet {
            loginPanel.isHidden = true
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showScene(.login)
    }

    // MARK: Actions

    @IBAction func loginWasTapped(_ sender: UIButton) {
        let result = self.login(withUser: userName.text, password: password.text)
        var message = ""
        switch result {
        case .success(let result):
            guard let resultMessage = result as? String else { assertionFailure("Result must be a string"); return }
            message = resultMessage
            self.showScene(.logout)
        case .failure(let error):
            message = error
        }

        let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func logoutWasTapped(_ sender: UIButton) {
        let result = self.logout(withDate: Date())
        var message = ""
        switch result {
        case .success(let result):
            guard let resultMessage = result as? String else { assertionFailure("Result must be a string"); return }
            message = resultMessage
            self.showScene(.login)
        case .failure(let error):
            message = error
        }

        let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: View Logic

    private func showScene(_ scene: Scene) {
        switch scene {
        case .login:
            self.loginPanel.isHidden = false
            self.logoutPanel.isHidden = true
        case .logout:
            self.loginPanel.isHidden = true
            self.logoutPanel.isHidden = false
        }
    }

    enum Scene {
        case login
        case logout
    }
}

struct Login {
    func login(withUser user: String?, password: String?) -> Result {
        if user == "admin" && password == "admin" {
            return Result.success(result: "OK")
        }
        return Result.failure(error: "A tomar por culo")
    }

    func logout(withDate date: Date) -> Result {
        if self.millisencondsFromDate(date) % 2 == 0 {
            return Result.success(result: "OK")
        }
        return Result.failure(error: "No te puedes escapar")
    }

    func millisencondsFromDate(_ date: Date) -> Int {
        return Int((date.timeIntervalSince1970 * 1000.0).rounded())
    }
}

enum Result {
    case success(result: Any)
    case failure(error: String)
}
