//
//  ViewController.swift
//  Semana 7
//
//  Created by Tecsup on 13/10/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var listaProfesores = [
        Profesor(nombre:"Jaime Gomez", cargo: "Coordinador de Software", foto: UIImage(named: "Avatar1")),
        Profesor(nombre: "Jaime Farfan", cargo: "Docente de Software TC", foto: UIImage(named: "Avatar1")),
        Profesor(nombre: "Juan León", cargo: "Docente de Software TC", foto: UIImage(named: "Avatar1")),
        Profesor(nombre: "Silvia Montoya", cargo: "Docente de Software TC", foto: UIImage(named: "Avatar2")),
        Profesor(nombre: "Theobaldo Diaz", cargo: "Docente de Software TC", foto: UIImage(named: "Avatar1")),
        Profesor(nombre: "Elliot Garamendi", cargo: "Docente de Software TC", foto: UIImage(named: "Avatar1")),
        Profesor(nombre: "Edwin Huerto", cargo: "Docente de Software TC", foto: UIImage(named: "Avatar1"))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("PROBANDO IMAGEN: \(String(describing: UIImage(named: "Avatar1"))) ")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaProfesores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda")!
                
        cell.textLabel?.text = listaProfesores[indexPath.row].nombre
        cell.detailTextLabel?.text = (listaProfesores[indexPath.row].cargo)
        cell.imageView?.image = listaProfesores[indexPath.row].foto
                
        return cell
    }
}
