//
//  RegistrolViewController.swift
//  prueba7
//
//  Created by Mario Saucedo on 10/4/17.
//  Copyright © 2017 Mario Ruben Saucedo. All rights reserved.
//

import UIKit
import Firebase

class RegistrolViewController: UIViewController {
    
    @IBOutlet weak var correoUsuarioLabel: UITextField!
    @IBOutlet weak var clave1UsuarioLabel: UITextField!
    @IBOutlet weak var clave2UsuarioLabel: UITextField!
    @IBOutlet weak var registrateButton: UIButton!
    @IBOutlet weak var nombreUsuarioLabel: UITextField!
    @IBOutlet weak var origenUsuarioLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        estilos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func leftArrowButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueLoginView", sender: self)
    }
    
    
    @IBAction func registrateButton(_ sender: UIButton) {
        
        
        registrarUsuario()
        
        
        /*let emailUsuario = correoUsuarioLabel.text
        let correoValido = isValidEmailAddress(emailAddressString: emailUsuario!)
        
        if correoValido {
            performSegue(withIdentifier: "segueMainMenu2", sender: self)
        }
        else{
            displayAlertMessage()
        }*/
    }
    
    func registrarUsuario() {
        guard let correo = correoUsuarioLabel.text, let contraseña = clave1UsuarioLabel.text, let nombre = nombreUsuarioLabel.text, let origen = origenUsuarioLabel.text else {
            print("datos erroneos")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: correo, password: contraseña, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error!)
            }
            else{
                print("Usuario registrado con exito")
            }
            
            /*let ref = FIRDatabase.database().reference().child("usuarios")
             let values = ["nombre": nombre, "correo": correo, "origen": origen]
             ref.childByAutoId().setValue(values){
             (err, ref) in
             
             if err != nil {
             print(err!)
             return
             }else{
             print("usuario registrado con exito en la bd")
             }
             }*/
            
            guard let uid = user?.uid else {
                return
            }
            
            let ref = FIRDatabase.database().reference()
            let usersReference = ref.child("usuarios").child(uid)
            let values = ["nombre": nombre, "correo": correo, "origen": origen, "rol": "Universitario"]
            usersReference.updateChildValues(values, withCompletionBlock: {
                (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }else{
                    print("usuario registrado con exito en la bd")
                    self.listoParaEnviar()
                }
            })
            
        })
    }
    
    func listoParaEnviar() {
        self.performSegue(withIdentifier: "goToMainMenu", sender: self)
    }
    
    func estilos() {
        let myColor = UIColor.white
        correoUsuarioLabel.layer.borderColor = myColor.cgColor
        correoUsuarioLabel.layer.borderWidth = 1.0
        correoUsuarioLabel.layer.cornerRadius = 15.0
        
        clave1UsuarioLabel.layer.borderColor = myColor.cgColor
        clave1UsuarioLabel.layer.borderWidth = 1.0
        clave1UsuarioLabel.layer.cornerRadius = 15.0
        
        clave2UsuarioLabel.layer.borderColor = myColor.cgColor
        clave2UsuarioLabel.layer.borderWidth = 1.0
        clave2UsuarioLabel.layer.cornerRadius = 15.0
        clave2UsuarioLabel.isEnabled = false
        
        nombreUsuarioLabel.layer.borderColor = myColor.cgColor
        nombreUsuarioLabel.layer.borderWidth = 1.0
        nombreUsuarioLabel.layer.cornerRadius = 15.0
        
        origenUsuarioLabel.layer.borderColor = myColor.cgColor
        origenUsuarioLabel.layer.borderWidth = 1.0
        origenUsuarioLabel.layer.cornerRadius = 15.0
        
        
        registrateButton.layer.cornerRadius = 15.0
    }
    

    /*func isValidEmailAddress(emailAddressString: String) -> Bool {
        
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
        let alertController = UIAlertController(title: "Alert", message: "Correo no valido", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }*/

}
