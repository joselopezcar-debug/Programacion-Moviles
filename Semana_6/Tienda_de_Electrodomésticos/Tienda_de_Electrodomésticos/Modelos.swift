//
//  Modelos.swift
//  Tienda_de_Electrodomésticos
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class Producto {
    let nombre: String
    let precio: Double
    var stock: Int
    
    init(nombre: String, precio: Double, stock: Int) {
        self.nombre = nombre
        self.precio = precio
        self.stock = stock
    }
}

class ItemCarrito {
    let producto: Producto
    var cantidad: Int
    
    init(producto: Producto, cantidad: Int) {
        self.producto = producto
        self.cantidad = cantidad
    }
    
    func subtotal() -> Double {
        return producto.precio * Double(cantidad)
    }
}

class CarritoModel {
    var items: [ItemCarrito] = []
    
    // TODO A1: Agregar producto validando el stock disponible
    func agregar(producto: Producto, cantidad: Int) -> Bool {
        // Buscar si el producto ya está en el carrito
        let itemExistente = items.first(where: { $0.producto.nombre == producto.nombre })
        let cantidadActualEnCarrito = itemExistente?.cantidad ?? 0
        
        // Regla 8: Si supera el stock, no agregar
        if (cantidadActualEnCarrito + cantidad) > producto.stock {
            return false
        }
        
        if let item = itemExistente {
            item.cantidad += cantidad
        } else {
            let nuevoItem = ItemCarrito(producto: producto, cantidad: cantidad)
            items.append(nuevoItem)
        }
        return true
    }
    
    // TODO A2: Suma de los subtotales de cada línea
    func subtotal() -> Double {
        return items.reduce(0.0) { $0 + $1.subtotal() }
    }
    
    // TODO A3 y Regla 6: Tramos de descuento sobre el subtotal
    func porcentajeDescuento() -> Double {
        let currentSubtotal = subtotal()
        if currentSubtotal >= 5000 { return 0.15 }
        if currentSubtotal >= 2000 { return 0.10 }
        if currentSubtotal >= 500  { return 0.05 }
        return 0.0
    }
    
    func montoDescuento() -> Double {
        return subtotal() * porcentajeDescuento()
    }
    
    func igv() -> Double {
        // El IGV (18%) se calcula sobre el monto descontado
        return (subtotal() - montoDescuento()) * 0.18
    }
    
    func total() -> Double {
        return subtotal() - montoDescuento() + igv()
    }
    
    // Regla 7: Categoría del cliente (con switch Int(subtotal))
    func categoriaCliente() -> String {
        let valor = Int(subtotal())
        switch valor {
        case ..<500:
            return "Regular"
        case 500...1999:
            return "Frecuente"
        case 2000...4999:
            return "VIP"
        default:
            return "Premium"
        }
    }
    
    // TODO A4: Suma de las cantidades de todas las líneas
    func cantidadTotal() -> Int {
        return items.reduce(0) { $0 + $1.cantidad }
    }
    
    // TODO A5: Vaciar el carrito
    func vaciar() {
        items.removeAll()
    }
    
    // Regla 9: Bajar stock al confirmar la compra
    func confirmarCompra() {
        for item in items {
            item.producto.stock -= item.cantidad
        }
        vaciar()
    }
}

class ClienteModel: NSObject {
    var Codigo: Int32 = 0
    var Apellido: String = ""
    var Nombre: String = ""
    var Dni: String = ""
    
    override init() {
        super.init()
        self.Codigo = 0
        self.Apellido = ""
        self.Nombre = ""
        self.Dni = ""
    }
    
    init(pCodigo: Int32, pApellido: String, pNombre: String, pDni: String) {
        super.init()
        self.Codigo = pCodigo
        self.Apellido = pApellido
        self.Nombre = pNombre
        self.Dni = pDni
    }
}
