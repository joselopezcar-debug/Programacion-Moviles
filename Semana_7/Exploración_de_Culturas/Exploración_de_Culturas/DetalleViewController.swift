//
//  DetalleViewController.swift
//  Exploración_de_Culturas
//
//  Created by Tecsup on 13/10/26.
//

import UIKit

class DetalleViewController: UIViewController {

    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var imagenImageView: UIImageView!
    
    @IBOutlet weak var descripciontestfield: UITextView!
    
    var atractivoSeleccionado: Atractivo?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let atractivo = atractivoSeleccionado {
            title = atractivo.titulo
            tituloLabel.text = atractivo.titulo
            imagenImageView.image = atractivo.imagen
            descripciontestfield.text = atractivo.descripcion
        }
    }
}
