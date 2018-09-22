//
//  SignUpMailViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/12.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class SignUpMailViewController: UIViewController {
    
    @IBOutlet weak var mailaddress: ContainButtonTextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
        self.warningLabel.isHidden = true
        self.nextButton.isEnabled = true
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
extension SignUpMailViewController {
    
    @IBAction func cancelSignUp(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        if let mailaddress = mailaddress.text {
            nextButton.isEnabled = false
            
            API.emailExistRequest(email: mailaddress) { (result) in
                if let res = result {
                    let viewController = SignUpPasswordViewController.instantiateViewController(mailaddress: res.email)
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    self.warningLabel.isHidden = false
                    self.nextButton.isEnabled = true
                }
            }
        }
    }
    
}
