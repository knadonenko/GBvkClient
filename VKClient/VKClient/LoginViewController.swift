//
//  LoginViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 31.10.2020.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loadingIndicator: DottedProgressBar!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        loadingIndicator.animate()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let userData = verifyLogin()
        
        if !userData {
            showLoginError()
            return userData
        } else {
            self.dismiss(animated: false)
            return userData
        }
    }
    
    func verifyLogin() -> Bool {
        
//        guard let login = loginInput.text, let password = passwordInput.text else {
//            return false
//        }
//
//        if login == "admin" && password == "123456" {
//            return true
//        } else {
//            return false
//        }
        
        return true
        
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Неверные логин и пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    



}
