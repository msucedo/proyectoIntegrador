//
//  DetailsTicketViewController.swift
//  prueba7
//
//  Created by Mario Saucedo on 10/9/17.
//  Copyright © 2017 Mario Ruben Saucedo. All rights reserved.
//

import UIKit
import Firebase

class DetailsTicketViewController: UIViewController {
    
    @IBOutlet weak var regresarLabel: UIButton!
    @IBOutlet weak var fechaGeneradoLabel: UILabel!
    @IBOutlet weak var horaGeneradoLabel: UILabel!
    @IBOutlet weak var RespondidoLabel: UILabel!
    @IBOutlet weak var estadoLabel: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fechaTicket()
        estadoTicket()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func regresarButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func fechaTicket() {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("preguntas").child(uid!).observe(.value, with: {
            (snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.fechaGeneradoLabel.text = dictionary["timestamp"] as? String
                print("PRUEBA de fecha funcionando")
            }
        })
    }
    
    func estadoTicket() {
        
    }
    
    

}
