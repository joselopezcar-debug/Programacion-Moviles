//
//  NuevaVentaViewController.swift
//  Calculadora_Ventas
//
//  Created by Tecsup on 13/10/26.
//

import UIKit

class NuevaVentaViewController: UIViewController {

    // IBOutlets conectados a los UITextField de entrada
    @IBOutlet weak var txtElectrodomestico: UITextField!
    @IBOutlet weak var txtPrecioUnitario: UITextField!
    @IBOutlet weak var txtCantidad: UITextField!
    @IBOutlet weak var txtMeses: UITextField!
    @IBOutlet weak var txtInteresMensual: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Preparación del envío de datos antes de ejecutar el Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Identificador del Segue: \(String(describing: segue.identifier))")
        print("Precio ingresado: \(txtPrecioUnitario.text ?? "Vacio")")
        
        if segue.identifier == "showResultado" {
            // Conversión de campos de texto a Double
            let precioUnitario = Double(txtPrecioUnitario.text ?? "") ?? 0.0
            let cantidad = Double(txtCantidad.text ?? "") ?? 0.0
            let meses = Double(txtMeses.text ?? "") ?? 0.0
            let tasaInteresMensual = Double(txtInteresMensual.text ?? "") ?? 0.0
            
            // Fórmulas requeridas
            let subtotal = precioUnitario * cantidad
            let igv = subtotal * 0.18
            let base = subtotal + igv
            let intereses = base * (tasaInteresMensual / 100.0) * meses
            let total = base + intereses
            let cuota = meses > 0 ? (total / meses) : 0.0
            
            // Construcción del modelo con los resultados
            let oVenta = VentaModel(
                subtotal: subtotal,
                igv: igv,
                base: base,
                intereses: intereses,
                total: total,
                cuota: cuota
            )
            
            // Asignación del modelo al controlador destino
            if let destinoVC = segue.destination as? ResultadoViewController {
                destinoVC.pVenta = oVenta
            }
        }
    }
}
