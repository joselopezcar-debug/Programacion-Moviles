//
//  DetalleViewController.swift
//  Tienda_de_Electrodomésticos
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class DetalleViewController: UIViewController {
    
    var producto: Producto!
    var carrito: CarritoModel!
    
    // Cantidad inicial a agregar
    var cantidadSeleccionada: Int = 1
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var precioLabel: UILabel!
    
    @IBOutlet weak var stockLabel: UILabel!
    
    @IBOutlet weak var cantidadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mostrar la información del producto seleccionado
        if let prod = producto {
            nombreLabel.text = prod.nombre
            precioLabel.text = String(format: "Precio: S/ %.2f", prod.precio)
            stockLabel.text = "Stock disponible: \(prod.stock)"
            cantidadLabel.text = "\(cantidadSeleccionada)"
        }
    }
    // Acción para el Stepper o botones de - / + (Opcional según tu diseño)
    @IBAction func cambiarCantidad(_ sender: UIStepper) {
        cantidadSeleccionada = Int(sender.value)
        cantidadLabel.text = "\(cantidadSeleccionada)"
    }
    // Acción del botón "Agregar al carrito"
    @IBAction func agregarAlCarritoTapped(_ sender: UIButton) {
        // Validar stock usando el método del modelo
        let exito = carrito.agregar(producto: producto, cantidad: cantidadSeleccionada)
        
        if exito {
            // Mostrar alerta de éxito y regresar
            let alerta = UIAlertController(title: "¡Logrado!", message: "Producto añadido al carrito.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alerta, animated: true)
        } else {
            // Regla 8: Alerta de stock insuficiente si supera el límite
            let alerta = UIAlertController(title: "Error", message: "Stock insuficiente en el almacén.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .destructive))
            present(alerta, animated: true)
        }
    }
}
