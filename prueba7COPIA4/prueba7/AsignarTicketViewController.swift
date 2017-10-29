//
//  AsignarTicketViewController.swift
//  prueba7
//
//  Created by Mario Saucedo on 10/24/17.
//  Copyright © 2017 Mario Ruben Saucedo. All rights reserved.
//

import UIKit
import Firebase

class AsignarTicketViewController: UIViewController {
    
    @IBOutlet weak var idAsignarTxtLabel: UITextField!
    @IBOutlet weak var asignarBtnLabel: UIButton!
    @IBOutlet weak var cancelarBtnLabel: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelarButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func asignarButton(_ sender: UIButton) {
        asignarTicket()
    }
    
    func asignarTicket() {
        var id = idAsignarTxtLabel.text
        //let uid = FIRAuth.auth()?.currentUser?.uid
        //FIRDatabase.database().reference().child("usuarios").child(uid!)
        let ref = FIRDatabase.database().reference()
        let usersReference = ref.child("usuarios").child(id!)
        let values = ["rol": "Bibliotecario"]
        usersReference.updateChildValues(values, withCompletionBlock: {
            (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }else{
                print("rol actualizado con EXITO")
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    
    
}
