//
//  CerrarTicketViewController.swift
//  prueba7
//
//  Created by Mario Saucedo on 10/24/17.
//  Copyright © 2017 Mario Ruben Saucedo. All rights reserved.
//

import UIKit

class CerrarTicketViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calificarTicket()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func calificarTicket() {
        
        let alertController = UIAlertController(title: "Calificame!", message: "¿Como estuvo mi servicio?", preferredStyle: .alert)
        
        
        alertController.addTextField { (textField) in
            textField.text = ""
        }
        
        alertController.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: {[weak alertController](_) in
            let textField = alertController?.textFields![0]
            print("prueba de alert")
        }))
        
        let OKAction = UIAlertAction(title: "Enviar", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            self.performSegue(withIdentifier: "goToMainMenu2", sender: self)
            
        }
        
        let CancelarAction = UIAlertAction(title: "Cancelar", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            self.performSegue(withIdentifier: "goToRightMenu", sender: self)
            
        }
        
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        /*let alertController = UIAlertController(title: "Calificar ticket", message: "Calificame", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = "shola"
        }
        
        alertController.addAction(UIAlertAction(title: "JEJE", style: .default, handler: {[weak alertController](_) in
        let textField = alertController?.textFields![0]
            print("vale berga)")
        }))
        self.present(alertController, animated: true, completion: nil)*/
    }

}
