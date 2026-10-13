//
//  BoletaViewController.swift
//  Tienda_de_Electrodomésticos
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class BoletaViewController: UIViewController {
    
    var carrito: CarritoModel!
    var cliente: ClienteModel!
    
    @IBOutlet weak var boletaTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func generarTicket() {
        guard let car = carrito, let cli = cliente else { return }
        
        // Obtener la categoría automática calculada en el modelo (Regla 7)
        let categoria = car.categoriaCliente()
        
        // Estructura del formato exigido en la página 5 del laboratorio
        var ticket = ""
        ticket += "=========== BOLETA DE COMPRA ===========\n"
        ticket += "Cliente: \(cli.Apellido), \(cli.Nombre) (\(categoria))\n"
        ticket += "DNI: \(cli.Dni)\n"
        ticket += "----------------------------------------\n"
        
        // Agregar cada producto del carrito
        for item in car.items {
            ticket += String(format: "%@ x%d   S/ %.2f\n", item.producto.nombre, item.cantidad, item.subtotal())
        }
        
        ticket += "----------------------------------------\n"
        ticket += String(format: "Subtotal: S/ %.2f\n", car.subtotal())
        ticket += String(format: "Descuento (%.0f%%): -S/ %.2f\n", car.porcentajeDescuento() * 100, car.montoDescuento())
        ticket += String(format: "IGV (18%%): S/ %.2f\n", car.igv())
        ticket += String(format: "TOTAL: S/ %.2f\n", car.total())
        ticket += "========================================\n"
        
        // Pintar el string final en nuestro elemento gráfico
        boletaTextView.text = ticket
    }
    
    @IBAction func cerrarBoletaTapped(_ sender: UIButton) {
        // Regla 9: El stock de cada producto baja según lo comprado y el carrito se vacía
        carrito.confirmarCompra()
        
        // Cerrar la ventana modal animada
        self.dismiss(animated: true) {
            // Reto opcional 1: Volver automáticamente al catálogo principal tras comprar
            if let navigation = self.presentingViewController as? UINavigationController {
                navigation.popToRootViewController(animated: true)
            }
        }
    }
}
