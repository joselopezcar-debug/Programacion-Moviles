//
//  OpcionesViewController.swift
//  Exploracion_de_Culturas
//
//  Created by Tecsup on 15/10/26.
//

import UIKit

class OpcionesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var culturaSeleccionada: Cultura?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        if let cultura = culturaSeleccionada {
            title = cultura.nombre
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return culturaSeleccionada?.atractivos.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaOpcion", for: indexPath) as! OpcionTableViewCell
        
        if let atractivo = culturaSeleccionada?.atractivos[indexPath.row] {
            cell.opcionTituloLabel.text = atractivo.titulo
            cell.opcionImageView.image = atractivo.imagen
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    // MARK: - Selección de celda y paso a Detalle
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let atractivo = culturaSeleccionada?.atractivos[indexPath.row] {
            performSegue(withIdentifier: "irADetalle", sender: atractivo)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irADetalle",
           let destinoVC = segue.destination as? DetalleViewController,
           let atractivo = sender as? Atractivo {
            destinoVC.atractivoSeleccionado = atractivo
        }
    }
}
