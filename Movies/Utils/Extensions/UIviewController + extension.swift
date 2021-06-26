//
//  UIviewController + extension.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 22/01/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit


extension UIViewController {
    
    
    private static func genrericInstance<T: UIViewController>() -> T {
        return T.init(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    public static func Instantiate() -> Self {
        return genrericInstance()
    }
    
    func hideNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addToolbar(searchTextField: UISearchBar) {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        let left = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(UIViewController.donePressed))
        toolbar.setItems([left,spaceButton,doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        searchTextField.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    func alert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
