//
//  LoginViewController.swift
//  prueba7
//
//  Created by Mario Saucedo on 10/2/17.
//  Copyright © 2017 Mario Ruben Saucedo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var correoLabel: UITextField!
    @IBOutlet weak var contraseñaLabel: UITextField!
    @IBOutlet weak var loginLabel: UIButton!
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        let emailUsuario = correoLabel.text
        let correoValido = isValidEmailAddress(emailAddressString: emailUsuario!)
        
        if correoValido && contraseñaLabel.text != ""{
            FIRAuth.auth()?.signIn(withEmail: correoLabel.text!, password: contraseñaLabel.text!, completion: { (user, error) in
                if error != nil {
                    print(error!)
                } else {
                    print("Inicio de sesion exitoso")
                    self.performSegue(withIdentifier: "segueMainMenu", sender: self)
                }
            })
        }
        else{
            displayAlertMessage()
        }
        
        
    }
    
    
    @IBAction func nuevoUsuarioButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueNuevoUsuario", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor = UIColor.white//.init(red: 0, green: 193, blue: 146, alpha: 1.0)
        correoLabel.layer.borderColor = myColor.cgColor
        correoLabel.layer.borderWidth = 1.0
        correoLabel.layer.cornerRadius = 15.0
        
        contraseñaLabel.layer.borderColor = myColor.cgColor
        contraseñaLabel.layer.borderWidth = 1.0
        contraseñaLabel.layer.cornerRadius = 15.0

        loginLabel.layer.cornerRadius = 15.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func isValidPassword(passwordString: String) -> Bool {
        var returnValue = true
        if passwordString. = "" {
            returnValue = false
        }
        else{
            returnValue = true
        }
        return returnValue
    }*/
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[a-zA-Z0-9._-]+@ucol.+mx+"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func displayAlertMessage(){
        let alertController = UIAlertController(title: "Alert", message: "Correo o contraseña no validos", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }

}
