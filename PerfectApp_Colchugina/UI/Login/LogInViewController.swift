//
//  ViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 23.04.2021.
//

import UIKit

class LogInViewController: UIViewController {

    //MARK:- private properties

    @IBOutlet weak private var welcomeLable: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var logInLable: UILabel!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordLable: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var logInButtonOutlet: UIButton!

    //MARK:- Life cycle

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //MARK:- Private methods

    @IBAction private func unwindToLogInAction(unwindSegue: UIStoryboardSegue) {}

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    //Показать клавиатуру
    @objc
    private func keyboardWasShown(notification: Notification) {

        // Получить размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)

        // Добавить отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }

    // Скрыть клавиатуру
    @objc
    private func keyboardWillBeHidden(notification: Notification) {
        // Установить отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }

    private func checkUserData() -> Bool {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return false }
        if login == "" && password == "" {
            loginTextField.text = ""
            passwordTextField.text = ""
            return true
        } else {
            return false
        }
    }

    private func showLoginError() {
        // Создать контроллер
        let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        // Создать кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавить кнопку на UIAlertController
        alter.addAction(action)
        // Показать UIAlertController
        present(alter, animated: true, completion: nil)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Проверить данные
        let checkResult = checkUserData()

        // Показать ошибку
        if !checkResult {
            showLoginError()
        }

        // Вернуть результат
        return checkResult
    }

}
