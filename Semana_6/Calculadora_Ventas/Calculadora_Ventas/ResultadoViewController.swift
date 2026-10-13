//
//  ResultadoViewController.swift
//  Calculadora_Ventas
//
//  Created by Tecsup on 13/10/26.
//

import UIKit

class ResultadoViewController: UIViewController {

    // IBOutlets conectados a los UILabel de resultado
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblIgv: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblIntereses: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCuota: UILabel!

    // Propiedad que recibirá el objeto enviado desde la vista anterior
    var pVenta: VentaModel = VentaModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Formateo e impresión de los datos en formato Soles (S/.)
        lblSubtotal.text = String(format: "S/. %.2f", pVenta.subtotal)
        lblIgv.text = String(format: "S/. %.2f", pVenta.igv)
        lblBase.text = String(format: "S/. %.2f", pVenta.base)
        lblIntereses.text = String(format: "S/. %.2f", pVenta.intereses)
        lblTotal.text = String(format: "S/. %.2f", pVenta.total)
        lblCuota.text = String(format: "S/. %.2f", pVenta.cuota)
    }
}
