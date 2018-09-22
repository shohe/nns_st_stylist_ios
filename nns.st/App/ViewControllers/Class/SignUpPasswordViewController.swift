//
//  SignUpPasswordViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/13.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class SignUpPasswordViewController: UIViewController {
    
    @IBOutlet weak var password: ContainButtonTextField!
    @IBOutlet weak var passwordConfirm: ContainButtonTextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    private var mailaddress: String?
    
    
    static func instantiateViewController(mailaddress: String) -> SignUpPasswordViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUpPasswordViewController") as! SignUpPasswordViewController
        viewController.mailaddress = mailaddress
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        warningLabel.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - IBAction
extension SignUpPasswordViewController {
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        if let password = password.text, let c_password = passwordConfirm.text {
            nextButton.isEnabled = false
            
            API.passwordConfirmRequest(password: password, c_password: c_password) { (result) in
                if let res = result {
                    let viewController = SignUpNameViewController.instantiateViewController(mailaddress: self.mailaddress!, password: res.password)
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    self.warningLabel.isHidden = false
                    self.nextButton.isEnabled = true
                }
            }
        }
    }
    
}
