//
//  ViewController.swift
//  App20220410Phone
//
//  Created by grace on 2022/4/10.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    // Format: +886921XXXXXX
    @IBOutlet weak var myPhoneNo: UITextField!
    
    @IBOutlet weak var myAuthCode: UITextField!
    
    var verID = "AJOnW4SCux1UAGuhIlvigO57vTOWLUU5vzntMgx9AQHIus1w5kNYyg1wT79lWfQPr_ywB0vRD-SAjWRq69csQELbNY7x7YdqHqsy85cN0XBGVHc9dnl7gR8WYfUcLoFGPN1mpGCAZfcdVxdgAH0OsWgfoU_lvIKk9HfMoBXAMD_mYcjvQMMWg1ji2w_fOXA1nA05LYKgk0lPVQ70hUhZ0as17xdFc1S60iL0VWZY8cYW3N_LBI7IITg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                // 已登入
                print("phone: \(String(describing: user.phoneNumber) )")
            } else {
                // 未登入
                print("not login !")
            }
        }
    }

    @IBAction func getAuthCode(_ sender: Any) {
        let phoneNum = myPhoneNo.text ?? ""
        
        // PhoneNumber Format
        
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phoneNum, uiDelegate: nil) { verificationID, error in
              if let error = error {
//                self.showMessagePrompt(error.localizedDescription)
                  print("error:\(error.localizedDescription)")
                return
              }
              // Sign in using the verificationID and the code sent to the user
              print("verificationID: \(String(describing: verificationID))")
              self.verID = verificationID ?? ""
          }
        
    }
    
    @IBAction func goLogin(_ sender: Any) {
        let code = myAuthCode.text ?? ""
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: self.verID,
          verificationCode: code
        )
        Auth.auth().signIn(with: credential)
    }
}

