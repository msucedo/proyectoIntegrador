//
//  ViewController.swift
//  prueba7
//
//  Created by Mario Saucedo on 10/2/17.
//  Copyright © 2017 Mario Ruben Saucedo. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var nuevoTicketButton: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var ticketsTableView: UITableView!
    
    var preguntasArray :  [Mensajes] = [Mensajes]()
    var indexPreguntas = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nuevoTicketButton.layer.cornerRadius = 15.0
        sideMenus()
        customizeNavbar()
        
        
        ticketsTableView.delegate = self
        ticketsTableView.dataSource = self
        
        ticketsTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
     
        confiTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tipoUsuario()
    }
    
    //provide cells that are going to be show, cual sera la celda que mostrare en la siguiente linea? ... aqui debo con un if intercambiar de celdas para el que pregunta y el que responde
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = preguntasArray[indexPath.row].pregunta
        cell.senderUsername.text = preguntasArray[indexPath.row].sender
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return preguntasArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPreguntas = indexPath.row
        performSegue(withIdentifier: "goToTicketSelected", sender: self)
        print(indexPreguntas)
    }
    
    func confiTableView() {
        ticketsTableView.rowHeight = UITableViewAutomaticDimension
        ticketsTableView.estimatedRowHeight = 120.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenus() {
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 225
        }
    }
    
    func customizeNavbar() {
        navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha:1)
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 32/255, green: 55/255, blue: 68/255, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    //llamar a todas las preguntas de todos los usuarios
    func llamarPreguntas() {
        
        
    }
    
    
    
    /*func llamarPreguntas() {
        
        let user = FIRAuth.auth()?.currentUser
        
        let correo = user?.email
        
        
        
        
        let preguntasDB = FIRDatabase.database().reference().child("preguntas")
        preguntasDB.observe(.childAdded, with: {
            (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let text = snapshotValue["pregunta"]!
            let sender = snapshotValue["sender"]!
            
            if correo == sender {
                let mensaje = Mensajes()
                mensaje.pregunta = text
                mensaje.sender = sender
                
                self.preguntasArray.append(mensaje)
                
                self.confiTableView()
                self.ticketsTableView.reloadData()
                
            }else{
                print("no es igual")
            }
        })
    }*/
    
    
    func tipoUsuario() {
        var rolUsuario = ""
        let uid = FIRAuth.auth()?.currentUser?.uid
        if uid != nil {
            FIRDatabase.database().reference().child("usuarios").child(uid!).observe(.value, with: {
                (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    rolUsuario = dictionary["rol"] as! String
                    
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
        else{
            rolUsuario = "Universitario"
        }
        
    }
    
    func usuarioUniver() {
        let user = FIRAuth.auth()?.currentUser
        if user != nil {
            let correo = user?.email
            let preguntasDB = FIRDatabase.database().reference().child("preguntas")
            
            preguntasDB.observe(.childAdded, with: {
                (snapshot) in
                //print(snapshot)
                
                let snapshotValue = snapshot.value as? [String: AnyObject]
                
                let text = snapshotValue?["pregunta"]!
                let sender = snapshotValue?["nombre"]!
                
                if correo == sender as! String {
                    let mensaje = Mensajes()
                    mensaje.pregunta = text as! String
                    mensaje.sender = sender as! String
                    
                    self.preguntasArray.append(mensaje)
                    
                    self.confiTableView()
                    self.ticketsTableView.reloadData()
                }
                else{
                    print("correo no es igual")
                }
                
            }, withCancel: nil)
            
        }else{
            print("no hay usuario se supone...")
        }
    }

    
    //Antigua forma de imprimir los tickets en pantalla
    /*func usuarioUniver() {
        let user = FIRAuth.auth()?.currentUser
        if user != nil {
            let correo = user?.email
            let preguntasDB = FIRDatabase.database().reference().child("preguntas")
            
            preguntasDB.observe(.childAdded, with: {
                (snapshot) in
                let snapshotValue = snapshot.value as! Dictionary<String, String>
                
                let text = snapshotValue["pregunta"]!
                let sender = snapshotValue["nombre"]!
                
                if correo == sender {
                    let mensaje = Mensajes()
                    mensaje.pregunta = text
                    mensaje.sender = sender
                    
                    self.preguntasArray.append(mensaje)
                    
                    self.confiTableView()
                    self.ticketsTableView.reloadData()
                }
                else{
                    print("correo no es igual")
                }
            })
            
        }else{
            print("no hay usuario se supone...")
        }
    }*/
    
    func usuarioBiblio() {
        nuevoTicketButton.isHidden = true
        let preguntasDB = FIRDatabase.database().reference().child("preguntas")
        preguntasDB.observe(.childAdded, with: {
            (snapshot) in
            //print(snapshot)
            
            let snapshotValue = snapshot.value as? [String: AnyObject]
            
            let text = snapshotValue?["pregunta"]!
            let sender = snapshotValue?["nombre"]!
            
            
            let mensaje = Mensajes()
            mensaje.pregunta = text as! String
            mensaje.sender = sender as! String
            
            self.preguntasArray.append(mensaje)
            
            self.confiTableView()
            self.ticketsTableView.reloadData()
            
            
        }, withCancel: nil)
    }
    
    func usuarioAdmin() {
        nuevoTicketButton.isHidden = true
        let preguntasDB = FIRDatabase.database().reference().child("preguntas")
        preguntasDB.observe(.childAdded, with: {
            (snapshot) in
            //print(snapshot)
            
            let snapshotValue = snapshot.value as? [String: AnyObject]
            
            let text = snapshotValue?["pregunta"]!
            let sender = snapshotValue?["nombre"]!
            
            
                let mensaje = Mensajes()
                mensaje.pregunta = text as! String
                mensaje.sender = sender as! String
                
                self.preguntasArray.append(mensaje)
                
                self.confiTableView()
                self.ticketsTableView.reloadData()
            
            
        }, withCancel: nil)

    }
    
    func usuarioResp() {
        nuevoTicketButton.isHidden = true
        let preguntasDB = FIRDatabase.database().reference().child("preguntas")
        preguntasDB.observe(.childAdded, with: {
            (snapshot) in
            //print(snapshot)
            
            let snapshotValue = snapshot.value as? [String: AnyObject]
            
            let text = snapshotValue?["pregunta"]!
            let sender = snapshotValue?["nombre"]!
            
            
            let mensaje = Mensajes()
            mensaje.pregunta = text as! String
            mensaje.sender = sender as! String
            
            self.preguntasArray.append(mensaje)
            
            self.confiTableView()
            self.ticketsTableView.reloadData()
            
            
        }, withCancel: nil)

    }
    

}
