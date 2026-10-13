//
//  DatosClienteViewController.swift
//  Tienda_de_Electrodomésticos
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class DatosClienteViewController: UIViewController {

    var carrito: CarritoModel!
    
    // Outlets de los campos de texto
    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDni: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func confirmarCompraTapped(_ sender: UIButton) {
        // Regla 8: Validar que los campos no estén vacíos
        guard let apellido = tfApellido.text, !apellido.isEmpty,
              let nombre = tfNombre.text, !nombre.isEmpty,
              let dni = tfDni.text, !dni.isEmpty else {
            
            mostrarAlerta(titulo: "Campos Vacíos", mensaje: "Todos los campos del cliente son obligatorios.")
            return
        }
        
        // Regla 8: Validar que el DNI tenga exactamente 8 dígitos
        if dni.count != 8 || Int(dni) == nil {
            mostrarAlerta(titulo: "DNI Inválido", mensaje: "El DNI debe tener exactamente 8 dígitos numéricos.")
            return
        }
        
        // Si todo está correcto, creamos el objeto ClienteModel (Reutilizando el del Ejercicio 2)
        let oCliente = ClienteModel(pCodigo: 1, pApellido: apellido, pNombre: nombre, pDni: dni)
        
        // Abrir la Boleta de forma Modal pasando el carrito y el cliente
        performSegue(withIdentifier: "verBoleta", sender: oCliente)
    }
    
    func mostrarAlerta(titulo: String, mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verBoleta" {
            let destino = segue.destination as! BoletaViewController
            destino.carrito = carrito
            destino.cliente = sender as? ClienteModel
        }
    }
}
