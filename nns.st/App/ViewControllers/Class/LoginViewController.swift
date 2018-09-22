//
//  LoginViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/12.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mailaddress: UnderlineTextField!
    @IBOutlet weak var password: UnderlineTextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LoginViewController {
    
    @IBAction func pushNextBtn(_ sender: UIButton) {
        if let email = mailaddress.text, let password = password.text {
            API.loginRequest(email: email, password: password) { (result) in
                if let res = result {
                    NNSCore.setAuthToken(res.item.token)
                    self.present(MainViewController.instantiateViewController(), animated: true, completion: nil)
                } else {
                    print("メールアドレスかパスワードが間違っています")
                }
            }
        } else {
            print("メールアドレスかパスワードが間違っています")
        }
    }
    
}
