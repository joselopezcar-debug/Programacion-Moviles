//
//  Cultura.swift
//  Exploración_de_Culturas
//
//  Created by Tecsup on 13/10/26.
//

import UIKit

class Cultura {
    var nombre: String
    var region: String
    var descripcion: String
    var imagen: UIImage?
    var atractivos: [Atractivo]
    
    init(nombre: String, region: String, descripcion: String, imagen: UIImage?, atractivos: [Atractivo]) {
        self.nombre = nombre
        self.region = region
        self.descripcion = descripcion
        self.imagen = imagen
        self.atractivos = atractivos
    }
}
