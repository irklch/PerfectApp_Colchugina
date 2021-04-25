//
//  ViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 23.04.2021.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBAction func unwindToLogInAction(unwindSegue: UIStoryboardSegue) {}
    @IBOutlet weak var welcomeLable: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logInLable: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLable: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //добавляем тап для скрытия клавиатуры
        let tapForHiddenKeybourd = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapForHiddenKeybourd)
        
        //отрисовываем нижнюю границу loginTextField и passwordTextField
        loginTextField.useUnderline(.black, 1.0)
        passwordTextField.useUnderline(.black, 1.0)
        
        //закругляем края кнопки и добавляем тень
        logInButtonOutlet.layer.cornerRadius = logInButtonOutlet.frame.height/2
        logInButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        logInButtonOutlet.layer.shadowOffset = CGSize(width: 0, height: 3)
        logInButtonOutlet.layer.shadowRadius = 4
        logInButtonOutlet.layer.shadowOpacity = 0.15
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            // Проверяем данные
            let checkResult = checkUserData()
            
            // Если данные не верны, покажем ошибку
            if !checkResult {
                showLoginError()
            }
            
            // Вернем результат
            return checkResult
        }
        
        func checkUserData() -> Bool {
            guard let login = loginTextField.text,
                let password = passwordTextField.text else { return false }
            
            if login == "admin" && password == "admin" {
                loginTextField.text = ""
                passwordTextField.text = ""
                return true
            } else {
                return false
            }
        }
        
        func showLoginError() {
            // Создаем контроллер
            let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
            // Создаем кнопку для UIAlertController
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            // Добавляем кнопку на UIAlertController
            alter.addAction(action)
            // Показываем UIAlertController
            present(alter, animated: true, completion: nil)
        }

}
