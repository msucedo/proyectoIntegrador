//
//  LeftSideMenuViewController.swift
//  prueba7
//
//  Created by Mario Saucedo on 10/7/17.
//  Copyright © 2017 Mario Ruben Saucedo. All rights reserved.
//

import UIKit
import Firebase

class LeftSideMenuViewController: UIViewController {
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var tipoDeUsuarioLabel: UILabel!
    @IBOutlet weak var IdUsuarioLabel: UILabel!
    @IBOutlet weak var cerrarSesionBtnLabel: UIButton!
    @IBOutlet weak var rolesbtnLabel: UIButton!
    @IBOutlet weak var reporteBtnLabel: UIButton!
    @IBOutlet weak var estadisticasBtnLabel: UIButton!
    
    var ref: FIRDatabaseReference?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tipoUsuario()
        IdDeUsuario()
        nombreDeUsuario()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func IdDeUsuario() {
        let user = FIRAuth.auth()?.currentUser
        if user != nil {
            let uid = user?.uid
            IdUsuarioLabel.text = uid
            print("id impreso en leftside")
        }
    }
    
    func nombreDeUsuario() {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
         FIRDatabase.database().reference().child("usuarios").child(uid!).observe(.value, with: {
         (snapshot) in
         if let dictionary = snapshot.value as? [String: AnyObject] {
         self.nombreLabel.text = dictionary["nombre"] as? String
            print("nombre impreso en leftside")
         }
         })
    }
    
    @IBAction func cerrarSesionButton(_ sender: UIButton) {
        do{
            try FIRAuth.auth()?.signOut()
            print("sesion cerrada con exito")
        }
        catch{
            print("error: hubo un problema al cerrar sesion")
        }
        performSegue(withIdentifier: "goToSignedOut", sender: self)
    }
    
    func tipoUsuario() {
       var rolUsuario = ""
       let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("usuarios").child(uid!).observe(.value, with: {
            (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                rolUsuario = dictionary["rol"] as! String
                self.tipoDeUsuarioLabel.text = rolUsuario
                
                if rolUsuario == "Universitario" {
                    self.usuarioUniver()
                }
                else if rolUsuario == "Administrador" {
                    self.usuarioAdmin()
                }
                else if rolUsuario == "Responsable" {
                    self.usuarioResp()
                }
                else if rolUsuario == "Bibliotecario" {
                    self.usuarioBiblio()
                }
            }
        })
    }
    
    func usuarioUniver() {
        rolesbtnLabel.isHidden = true
        reporteBtnLabel.isHidden = true
        estadisticasBtnLabel.isHidden = true
    }
    
    func usuarioBiblio() {
        rolesbtnLabel.isHidden = true
        reporteBtnLabel.isHidden = true
        estadisticasBtnLabel.isHidden = true
    }
    
    func usuarioAdmin() {
        rolesbtnLabel.isHidden = false
        reporteBtnLabel.isHidden = false
        estadisticasBtnLabel.isHidden = false
    }
    
    func usuarioResp() {
        rolesbtnLabel.isHidden = false
        reporteBtnLabel.isHidden = true
        estadisticasBtnLabel.isHidden = true
    }
    
    @IBAction func rolesButton(_ sender: UIButton) {
        var rolUsuario = ""
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("usuarios").child(uid!).observe(.value, with: {
            (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                rolUsuario = dictionary["rol"] as! String
                
                if rolUsuario == "Responsable" {
                    self.performSegue(withIdentifier: "goToRolesResponsable", sender: self)
                }
                else if rolUsuario == "Administrador" {
                    self.performSegue(withIdentifier: "goToRolesAdmin", sender: self)
                }
                
            }
        })
    }
    
}
