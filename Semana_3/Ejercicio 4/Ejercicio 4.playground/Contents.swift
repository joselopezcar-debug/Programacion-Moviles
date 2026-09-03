// Desarrollado por: [José Alonso]

import Foundation

// TODO 10: Inventario de productos
print("¿Cuántos productos?")
let n = Int(readLine() ?? "") ?? 0

//Validar que n sea mayor que 0
if n <= 0 {
    print("Error: Debe ingresar al menos 1 producto")
    // Terminar el programa o pedir nuevamente
} else {
    var precios: [String: Double] = [:]
    var stocks: [String: Int] = [:]
    
    for i in 1...n {
        print("Producto \(i) - Nombre:")
        let nombre = readLine() ?? ""
        print("Precio:")
        let precio = Double(readLine() ?? "") ?? 0
        print("Stock:")
        let stock = Int(readLine() ?? "") ?? 0
        precios[nombre] = precio
        stocks[nombre] = stock
    }
    
    // Calcular valor total (precio x stock)
    var valorInventario = 0.0
    for (nombre, precio) in precios {
        if let stock = stocks[nombre] {
            let valorProducto = precio * Double(stock)
            valorInventario += valorProducto
            print("\(nombre): \(stock) unidades x S/.\(precio) = S/.\(valorProducto)")
        }
    }
    print("\nValor total del inventario: S/. \(valorInventario)")
    
    // Mostrar productos con stock < 5
    print("\n=== PRODUCTOS CON STOCK BAJO (< 5) ===")
    var hayStockBajo = false
    for (nombre, stock) in stocks {
        if stock < 5 {
            hayStockBajo = true
            if let precio = precios[nombre] {
                print("\(nombre): \(stock) unidades - S/.\(precio) c/u")
            }
        }
    }
    if !hayStockBajo {
        print("No hay productos con stock bajo")
    }
}
