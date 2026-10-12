//
//  ViewController.swift
//  Semana06_02
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDNI: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btncontinuar(_ sender: Any) {
        // 1. Crear el objeto del modelo con los datos escritos en los Text Fields
            let oCliente = ClienteModel(pCodigo: 0,
                                        pApellido: self.tfApellido.text!,
                                        pNombre: self.tfNombre.text!,
                                        pDni: self.tfDNI.text!)
            
            // 2. Apuntar al Storyboard principal llamado "Main"
            let osb = UIStoryboard(name: "Main", bundle: nil)
            
            // 3. Crear una instancia de la segunda pantalla usando su Storyboard ID
        let oPantalla2 = osb.instantiateViewController(identifier: "ViewControllerConfirmacion")as! ViewControllerConfirmacion
            
            // 4. Pasar los datos del objeto al parámetro de la segunda pantalla
            oPantalla2.pCliente = oCliente
            
            // 5. Presentar la pantalla de forma Modal
            self.present(oPantalla2, animated: true, completion: nil)
    }
    

}

