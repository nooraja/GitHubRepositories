//
//  LoginVC.swift
//  GitHubRepositories
//
//  Created by Thieu Nguyen on 27/5/19.
//  Copyright © 2019 Mao. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginVC: UIViewController {

    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.Titles.LOGIN
        usernameTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearTextFields()
        viewModel.bindingData()
        blindUI()
        if UserData.sharedInstance().isLogin {
            openMainScreen()
        }
    }

    private func blindUI() {
        usernameTextField.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .asObservable()
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty.asObservable()
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        viewModel.isValid.asObservable().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
    }

    // MARK: Action Methods
    @IBAction func loginButtonAction(_ sender: Any) {
        viewModel.saveUserInfo()
        closeKeyboard()
        openMainScreen()
    }

    @IBAction func closeKeyboardAction(_ sender: Any) {
        closeKeyboard()
    }

    // MARK: Private Methods
    private func closeKeyboard() {
        view.endEditing(true)
    }

    private func clearTextFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }

    private func openMainScreen() {
        // open Main Screen
        let mainVC = MainVC()
        let naviController = UINavigationController(rootViewController: mainVC)
        present(naviController, animated: true, completion: nil)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.becomeFirstResponder()
        return true
    }
}
