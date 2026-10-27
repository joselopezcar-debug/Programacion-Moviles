//
//  ViewController.swift
//  Exploración_de_Culturas
//
//  Created by Tecsup on 13/10/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var listaCulturas: [Cultura] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Culturas Peruanas"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        cargarCulturas()
    }
    
    func cargarCulturas() {
        listaCulturas = [
            // 1. Nazca
            Cultura(
                nombre: "Nazca",
                region: "Ica",
                descripcion: "Cultura reconocida por sus geoglifos e ingeniería hidráulica.",
                imagen: UIImage(named: "nazca"),
                atractivos: [
                    Atractivo(
                        titulo: "Líneas de Nazca",
                        imagen: UIImage(named: "lineas_nazca"),
                        descripcion: "Enigmáticos geoglifos grabados en las pampas de Jumana, que representan figuras geométricas, animales y plantas visibles desde el aire."
                    ),
                    Atractivo(
                        titulo: "Acueductos de Cantalloc",
                        imagen: UIImage(named: "cantalloc"),
                        descripcion: "Sofisticada red de pozos e ingeniería subterránea que permitía extraer agua del subsuelo para la agricultura en el desierto."
                    ),
                    Atractivo(
                        titulo: "Centro Ceremonial Cahuachi",
                        imagen: UIImage(named: "cahuachi"),
                        descripcion: "La gran capital teocrática de barro más extensa del mundo precolombino, usada para rituales, peregrinaciones y ofrendas."
                    )
                ]
            ),
            
            // 2. Moche
            Cultura(
                nombre: "Moche",
                region: "La Libertad",
                descripcion: "Destacada por su arquitectura de adobe, orfebrería y huacos retratos.",
                imagen: UIImage(named: "moche"),
                atractivos: [
                    Atractivo(
                        titulo: "Tumba del Señor de Sipán",
                        imagen: UIImage(named: "sipan"),
                        descripcion: "Suntuoso hallazgo de la tumba intacta de un gobernante moche, acompañado de ornamentos de oro, plata y gemas semipreciosas."
                    ),
                    Atractivo(
                        titulo: "Huacas del Sol y de la Luna",
                        imagen: UIImage(named: "huaca_sol_luna"),
                        descripcion: "Santuarios monumentales de adobe que sirvieron como centros administrativos y religiosos principales de la sociedad mochica."
                    ),
                    Atractivo(
                        titulo: "Cerámica y Huacos Retratos",
                        imagen: UIImage(named: "huacos_moche"),
                        descripcion: "Arte alfarero caracterizado por plasmar con realismo las expresiones, estados de ánimo, rituales e iconografía moche."
                    )
                ]
            ),
            
            // 3. Paracas
            Cultura(
                nombre: "Paracas",
                region: "Ica",
                descripcion: "Famosa por sus fardos funerarios y técnicas quirúrgicas.",
                imagen: UIImage(named: "paracas"),
                atractivos: [
                    Atractivo(
                        titulo: "Mantos Paracas",
                        imagen: UIImage(named: "mantos_paracas"),
                        descripcion: "Textiles funerarios de finísimo bordado con hilos de algodón, lana de camélidos, tintes naturales y complejos motivos misticos."
                    ),
                    Atractivo(
                        titulo: "Trepanaciones Craneanas",
                        imagen: UIImage(named: "trepanaciones"),
                        descripcion: "Avanzadas intervenciones quirúrgicas en el cráneo para sanar traumatismos o fines rituales, usando instrumental de obsidiana."
                    ),
                    Atractivo(
                        titulo: "Candelabro de Paracas",
                        imagen: UIImage(named: "candelabro"),
                        descripcion: "Gigantesco geoglifo de más de 180 metros grabado sobre una colina de arena frente a la bahía de Paracas."
                    )
                ]
            ),
            
            // 4. Chavín
            Cultura(
                nombre: "Chavín",
                region: "Áncash",
                descripcion: "Cultura matriz andina con escultura religiosa y arquitectura en piedra.",
                imagen: UIImage(named: "chavin"),
                atractivos: [
                    Atractivo(
                        titulo: "Lanzón Monolítico",
                        imagen: UIImage(named: "lanzon"),
                        descripcion: "Escultura mítica de piedra de más de 4 metros ubicada en el interior de los pasajes subterráneos del templo Chavín de Huántar."
                    ),
                    Atractivo(
                        titulo: "Cabezas Clavas",
                        imagen: UIImage(named: "cabezas_clavas"),
                        descripcion: "Monolitos esculpidos que representaban a guardianes antropomorfos y transformaciones chamánicas en los muros del templo."
                    ),
                    Atractivo(
                        titulo: "Templo Chavín de Huántar",
                        imagen: UIImage(named: "templo_chavin"),
                        descripcion: "Centro ceremonial precolombino con galerías subterráneas, plazas hundidas y canales acotados para efectos acústicos rituales."
                    )
                ]
            ),
            
            // 5. Inca
            Cultura(
                nombre: "Inca",
                region: "Cusco",
                descripcion: "Gran imperio precolombino con impresionante ingeniería civil.",
                imagen: UIImage(named: "Inca"),
                atractivos: [
                    Atractivo(
                        titulo: "Santuario de Machu Picchu",
                        imagen: UIImage(named: "machu_picchu"),
                        descripcion: "Obra maestra de arquitectura e ingeniería encaramada sobre una cresta montañosa, considerada Patrimonio de la Humanidad."
                    ),
                    Atractivo(
                        titulo: "Fortaleza de Sacsayhuamán",
                        imagen: UIImage(named: "sacsayhuaman"),
                        descripcion: "Complejo ceremonial famoso por sus megalíticos muros de piedra tallada y ensamblada con precisión sin mortero."
                    ),
                    Atractivo(
                        titulo: "Templo del Qorikancha",
                        imagen: UIImage(named: "qorikancha"),
                        descripcion: "El templo principal dedicado al Dios Sol, cuyas paredes e ídolos estaban recubiertos originalmente con láminas de oro puro."
                    )
                ]
            )
        ]
        
        tableView.reloadData()
    }

    // MARK: - Métodos de UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCulturas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaCultura", for: indexPath)
        let cultura = listaCulturas[indexPath.row]
        
        cell.textLabel?.text = cultura.nombre
        cell.detailTextLabel?.text = cultura.region
        cell.imageView?.image = cultura.imagen
        
        return cell
    }

    // MARK: - Ejecutar el Segue Manualmente
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cultura = listaCulturas[indexPath.row]
        performSegue(withIdentifier: "irAOpciones", sender: cultura)
    }

    // MARK: - Pasar la información a la Pantalla 2 (Detalle)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irAOpciones",
           let destinoVC = segue.destination as? OpcionesViewController,
           let cultura = sender as? Cultura {
            destinoVC.culturaSeleccionada = cultura
        }
    }
}
