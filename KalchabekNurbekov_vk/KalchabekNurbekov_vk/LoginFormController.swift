//
//  ViewController.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 02.04.2022.
//

import UIKit
import Foundation
@IBDesignable

class LoginFormController: UIViewController {
    
    let session = Session.instance //синглтон текущей сессии
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loadingStack: UIStackView!
    @IBOutlet weak var pointOne: UIView!
    @IBOutlet weak var pointTwo: UIView!
    @IBOutlet weak var pointThree: UIView!
    @IBAction func enterButton(_ sender: Any) {
        loadingStack.isHidden = false
        loginInput.isHidden = true
        passwordInput.isHidden = true
        UIView.animateKeyframes(withDuration: 0.7,
                                delay: 0,
                                options: .repeat,
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                self.pointOne.alpha = 0.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.66, animations: {
                self.pointTwo.alpha = 0.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 1, animations: {
                self.pointThree.alpha = 0.0
            })


        },
                                completion: nil)
    }
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointOne.layer.cornerRadius = pointOne.bounds.height/2
        pointTwo.layer.cornerRadius = pointTwo.bounds.height/2
        pointThree.layer.cornerRadius = pointThree.bounds.height/2
       
        loadingStack.isHidden = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideScreen))
        view.addGestureRecognizer(tapGR)
    }
    @objc func hideScreen() {
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willHideNotification(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    @objc func willShowKeyboard(_ notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else
              {return}
        let keyboardHeight = keyboardSize.cgRectValue.size.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    
    @objc func willHideNotification(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        if !checkResult { showLoginError()
        }
        return checkResult }
    func checkUserData() -> Bool {
        guard let login = loginInput.text,
              let password = passwordInput.text else { return false }
        if login == "" && password == "" { return true
        } else {
            return false
        }
    }
    func showLoginError() {
        let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: {
            self.loadingStack.isHidden = true
            self.loginInput.isHidden = false
            self.passwordInput.isHidden = false
            self.loginInput.text = ""
            self.passwordInput.text = ""
        }) }
    
}
