//
//  ViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 23.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeLable: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logInLable: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLable: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func signInButton(_ sender: UIButton) {
        if loginTextField.text == "" {
            loginTextField.backgroundColor = .red
        }
        else {
            loginTextField.backgroundColor = .clear
        }
        if passwordTextField.text == "" {
            passwordTextField.backgroundColor = .red
        }
        else {
            passwordTextField.backgroundColor = .clear
        }
        if loginTextField.text == "admin" && passwordTextField.text == "admin" {
            
            welcomeLable.text = "BINGO 🎉"
            logInLable.isHidden = true
            loginTextField.isHidden = true
            passwordLable.isHidden = true
            passwordTextField.isHidden = true
            sender.isHidden = true
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapForHiddenKeybourd = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapForHiddenKeybourd)
       
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

