//
//  NuevoTicketViewController.swift
//  prueba7
//
//  Created by Mario Saucedo on 10/7/17.
//  Copyright © 2017 Mario Ruben Saucedo. All rights reserved.
//

import UIKit
import Firebase

enum estados {
    case nuevo
    case enProceso
    case cerrado
}



class NuevoTicketViewController: UIViewController {
    
    @IBOutlet weak var enviarButton: UIButton!
    @IBOutlet weak var mensajeTextField: UITextField!
    
    var estadoNuevo : estados = .nuevo

    override func viewDidLoad() {
        super.viewDidLoad()

        enviarButton.layer.cornerRadius = 15.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enviarButton(_ sender: UIButton) {
       enviarPregunta()
    }
    
    func enviarPregunta() {
        mensajeTextField.isEnabled = false
        enviarButton.isEnabled = false
        
        let preguntasDB = FIRDatabase.database().reference().child("preguntas")
        
        let timestamp = NSDate().timeIntervalSince1970
        
        let preguntasDictionary = ["nombre": FIRAuth.auth()?.currentUser?.email!, "pregunta": mensajeTextField.text!, "estado": "nuevo", "timestamp": timestamp] as [String : Any]
    
        preguntasDB.childByAutoId().setValue(preguntasDictionary) {
            (error, ref) in
            
            if error != nil{
                print(error!)
            }
            else{
                print("pregunta guardada con exito")
                self.mensajeTextField.isEnabled = true
                self.enviarButton.isEnabled = true
                self.mensajeTextField.text = ""
            }
        }
    }
    
    /*func enviarPregunta() {
        mensajeTextField.isEnabled = false
        enviarButton.isEnabled = false
        
        let preguntasDB = FIRDatabase.database().reference().child("preguntas")
        
        let timestamp = NSDate().timeIntervalSince1970
        
        let preguntasDictionary = ["nombre": FIRAuth.auth()?.currentUser?.email!, "pregunta": mensajeTextField.text!, "estado": "nuevo", "timestamp": timestamp] as [String : Any]
        
        preguntasDB.childByAutoId().setValue(preguntasDictionary) {
            (error, ref) in
            
            if error != nil{
                print(error!)
            }
            else{
                print("pregunta guardada con exito")
                self.mensajeTextField.isEnabled = true
                self.enviarButton.isEnabled = true
                self.mensajeTextField.text = ""
            }
        }
    }*/
    

}
