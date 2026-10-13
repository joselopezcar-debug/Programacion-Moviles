//
//  CarritoViewController.swift
//  Tienda_de_Electrodomésticos
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class CarritoViewController: UIViewController {
    var carrito: CarritoModel!
    
    
    @IBOutlet weak var itemsTextView: UITextView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var descuentoLabel: UILabel!
    @IBOutlet weak var igvLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        itemsTextView.isEditable = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mostrarResumen()
    }
    
    // Método para vaciar los datos del modelo en los componentes gráficos
    func mostrarResumen() {
        guard let car = carrito else { return }
        
        // 1. Armar el listado de productos de forma textual
        var textoItems = ""
        if car.items.isEmpty {
            textoItems = "El carrito está totalmente vacío."
        } else {
            for item in car.items {
                textoItems += String(format: "%@ x%d   S/ %.2f\n",
                                    item.producto.nombre,
                                    item.cantidad,
                                    item.subtotal())
            }
        }
        itemsTextView.text = textoItems
        
        // 2. Cargar los cálculos financieros desde el modelo (Regla 5 y 6)
        let porcentaje = car.porcentajeDescuento() * 100
        subtotalLabel.text = String(format: "Subtotal: S/ %.2f", car.subtotal())
        descuentoLabel.text = String(format: "Descuento (%.0f%%): -S/ %.2f", porcentaje, car.montoDescuento())
        igvLabel.text = String(format: "IGV (18%%): S/ %.2f", car.igv())
        totalLabel.text = String(format: "TOTAL: S/ %.2f", car.total())
    }
    
    // Acción conectada al botón "Finalizar compra"
    @IBAction func finalizarCompraTapped(_ sender: UIButton) {
        // Regla 8: Validar que no se intente avanzar si el carrito está vacío
        if carrito.items.isEmpty {
            let alerta = UIAlertController(title: "Carrito Vacío",
                                           message: "Debes agregar al menos un producto para proceder con la compra.",
                                           preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default))
            present(alerta, animated: true)
            return
        }
        
        // Disparar el segue hacia la pantalla de Datos del Cliente
        performSegue(withIdentifier: "irDatosCliente", sender: nil)
    }
    
    // Pasar el objeto único de carrito a la siguiente pantalla (Regla 2)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irDatosCliente" {
            let destino = segue.destination as! DatosClienteViewController
            destino.carrito = carrito // Se comparte la misma referencia de memoria
        }
    }
}
