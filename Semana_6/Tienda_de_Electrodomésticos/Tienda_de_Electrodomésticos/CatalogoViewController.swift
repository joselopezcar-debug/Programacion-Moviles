//
//  CatalogoViewController.swift
//  Tienda_de_Electrodomésticos
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class CatalogoViewController: UIViewController {
    
    let productos: [Producto] = [
        Producto(nombre: "Refrigeradora", precio: 2000, stock: 5),
        Producto(nombre: "Licuadora", precio: 250, stock: 10),
        Producto(nombre: "Laptop", precio: 3500, stock: 3),
        Producto(nombre: "Cocina", precio: 1200, stock: 4)
    ]
    
    let carrito = CarritoModel()
    
    @IBOutlet weak var verCarritoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO B2: Actualiza el título del botón con la cantidad total
        let conteo = carrito.cantidadTotal()
        verCarritoButton.setTitle("Ver Carrito (\(conteo))", for: .normal)
    }
    

    @IBAction func productoTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "verDetalle", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verDetalle" {
            let boton = sender as! UIButton
            let destino = segue.destination as! DetalleViewController
            // Elige el producto según el Tag (0, 1, 2 o 3) asignado en el Storyboard
            destino.producto = productos[boton.tag]
            destino.carrito = carrito
        }
        // TODO B1: Caso "verCarrito" -> pasa el carrito a CarritoViewController
        else if segue.identifier == "verCarrito" {
            let destino = segue.destination as! CarritoViewController
            destino.carrito = carrito
        }
    }
}
