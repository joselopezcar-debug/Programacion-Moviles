import UIKit
import CoreData

class SesionManager {
    static let shared = SesionManager()
    var usuarioActual: Usuario?

    var contexto: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func cerrarSesion() {
        usuarioActual = nil
    }
}
