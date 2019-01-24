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
        let result = Login.login(withUser: userName.text, password: password.text)
        var message = ""
        switch result {
        case .success:
            message = "OK"
            self.showScene(.logout)
        case .failure:
            message = "Datos incorrectos"
        }

        let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func logoutWasTapped(_ sender: UIButton) {
        let result = Logout.logout(withTimeProvider: TimeProvider())
        var message = ""
        switch result {
        case .success:
            message = "OK"
            self.showScene(.login)
        case .failure:
            message = "No te puedes escapar"
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
    static func login(withUser user: String?, password: String?) -> Result {
        if user == "admin" && password == "admin" {
            return Result.success
        }
        return Result.failure
    }
}

struct Logout {
    static func logout(withTimeProvider timeProvider: TimeProvider) -> Result {
        if timeProvider.currentTimeInSeconds() % 2 == 0 {
            return Result.success
        }
        return Result.failure
    }

    static func millisencondsFromDate(_ date: Date) -> Int {
        return Int(date.timeIntervalSince1970.rounded())
    }
}

class TimeProvider {
    func currentTimeInSeconds() -> Int {
        return Int(Date().timeIntervalSince1970.rounded())
    }
}

class MockTimeProvider: TimeProvider {
    var currentTime: Int

    init(currentTimeInSeconds: Int) {
        self.currentTime = currentTimeInSeconds
    }

    override func currentTimeInSeconds() -> Int {
        return currentTime
    }
}

enum Result {
    case success
    case failure
}
