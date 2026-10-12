//
//  ViewControllerConfirmacion.swift
//  Semana06_02
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class ViewControllerConfirmacion: UIViewController {

    // Instanciar la clase ClienteModel
    var pCliente: ClienteModel = ClienteModel()
    // Definir los controles de texto (Labels de salida)
    
    @IBOutlet weak var tfApellido: UILabel!
    
    @IBOutlet weak var tfNombre: UILabel!
    
    
    @IBOutlet weak var tfDNI: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfApellido.text = pCliente.Apellido
        self.tfNombre.text = pCliente.Nombre
        self.tfDNI.text = pCliente.Dni
    }
}

