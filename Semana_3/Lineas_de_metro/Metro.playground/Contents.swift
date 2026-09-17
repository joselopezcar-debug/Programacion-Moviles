import Foundation

// 1. ESTRUCTURA DE LA TARJETA DE TRANSPORTE
struct TarjetaTransporte {
    let id: String
    var saldo: Double
}

// 2. PRECIO DEL PASAJE (Tarifa plana Metro de Lima)
let TARIFA_METRO = 1.50

// 3. DATOS DE LAS LÍNEAS DEL METRO
let lineas = [
    "Línea 1": [
        "Bayóvar", "Central", "Gamarra", "Miguel Grau", "Angamos",
        "Cabitos", "Ayacucho", "Jorge Chávez", "Atocongo", "San Juan",
        "Villa El Salvador", "Parque Industrial"
    ],
    "Línea 2": [
        "Puerta del Sol", "Óvalo Santa Anita", "Mercado Santa Anita",
        "Estación Central", "Caja de Agua", "El Ángel", "Presbítero Maestro",
        "Central"
    ]
]

// 4. CONEXIONES ENTRE LÍNEAS (Estaciones de transferencia)
let conexiones = [
    "Central": ["Línea 1", "Línea 2"],
    "Miguel Grau": ["Línea 1", "Línea 2"]
]

// 5. MAPA INVERSO DE ESTACIONES
var estacionALinea: [String: String] = [:]
for (linea, estaciones) in lineas {
    for estacion in estaciones {
        estacionALinea[estacion] = linea
    }
}

// 1. MÉTODOS DE LA TARJETA (Extensiones de funcionalidad)
extension TarjetaTransporte {
    mutating func recargar(monto: Double) {
        guard monto > 0 else {
            print("\n❌ El monto a recargar debe ser mayor a cero.")
            return
        }
        saldo += monto
        print("\n💳 Recarga exitosa. Nuevo saldo: S/ \(String(format: "%.2f", saldo))")
    }
    
    mutating func descontar(tarifa: Double) -> Bool {
        if saldo >= tarifa {
            saldo -= tarifa
            print("\n✅ Pasaje cobrado. Saldo restante: S/ \(String(format: "%.2f", saldo))")
            return true
        } else {
            print("\n❌ Saldo insuficiente (S/ \(String(format: "%.2f", saldo))). El pasaje cuesta: S/ \(String(format: "%.2f", tarifa))")
            return false
        }
    }
}

// 2. ALGORITMO DE BÚSQUEDA DE RUTA
let buscarRuta = { (inicio: String, fin: String) -> [String] in
    var cola: [(estacion: String, ruta: [String])] = [(inicio, [inicio])]
    var visitados: Set<String> = []
    
    while !cola.isEmpty {
        let (actual, rutaActual) = cola.removeFirst()
        if actual == fin { return rutaActual }
        if visitados.contains(actual) { continue }
        visitados.insert(actual)
        
        let lineaActual = estacionALinea[actual] ?? ""
        
        // Vecinos en la misma línea
        if let estaciones = lineas[lineaActual] {
            if let index = estaciones.firstIndex(of: actual) {
                if index > 0 {
                    let vecino = estaciones[index - 1]
                    if !visitados.contains(vecino) { cola.append((vecino, rutaActual + [vecino])) }
                }
                if index < estaciones.count - 1 {
                    let vecino = estaciones[index + 1]
                    if !visitados.contains(vecino) { cola.append((vecino, rutaActual + [vecino])) }
                }
            }
        }
        
        // Transbordos
        if let lineasConectadas = conexiones[actual] {
            for otraLinea in lineasConectadas {
                if otraLinea != lineaActual, let estacionesOtraLinea = lineas[otraLinea] {
                    for vecino in estacionesOtraLinea {
                        if !visitados.contains(vecino), let indexActual = estacionesOtraLinea.firstIndex(of: actual),
                           let indexVecino = estacionesOtraLinea.firstIndex(of: vecino), abs(indexActual - indexVecino) == 1 {
                            cola.append((vecino, rutaActual + [vecino]))
                        }
                    }
                }
            }
        }
    }
    return []
}

// 1. VARIABLES DE ESTADO DEL SISTEMA Y ADMINISTRACIÓN
var miTarjeta = TarjetaTransporte(id: "LIMA-2026", saldo: 0.0)
var tarifaActual = TARIFA_METRO
var estacionesBloqueadas: Set<String> = []
let CLAVE_ADMIN = "admin123"

var ejecutarMenu = true

// 2. BUCLE DEL MENÚ INTERACTIVO PRINCIPAL
print("=== BIENVENIDO AL SISTEMA DEL METRO DE LIMA ===")

while ejecutarMenu {
    print("\n--- MENÚ DE PASAJERO ---")
    print("1. Ver saldo de la tarjeta")
    print("2. Recargar tarjeta")
    print("3. Simular viaje (Pasar por torniquete)")
    print("4. Ingresar al Modo Administrador")
    print("5. Salir")
    print("Seleccione una opción: ", terminator: "")
    
    if let entrada = readLine(), let opcion = Int(entrada) {
        switch opcion {
        case 1:
            print("\n💳 Tarjeta ID: \(miTarjeta.id) | Saldo actual: S/ \(String(format: "%.2f", miTarjeta.saldo))")
            
        case 2:
            print("Ingrese el monto a recargar: S/ ", terminator: "")
            if let entradaMonto = readLine(), let monto = Double(entradaMonto) {
                miTarjeta.recargar(monto: monto)
            } else {
                print("❌ Monto inválido.")
            }
            
        case 3:
            print("Ingrese estación de origen: ", terminator: "")
            let origen = readLine() ?? ""
            print("Ingrese estación de destino: ", terminator: "")
            let destino = readLine() ?? ""
            
            // Validar que las estaciones existan en la red
            if estacionALinea[origen] == nil || estacionALinea[destino] == nil {
                print("❌ Una o ambas estaciones no existen en la red del metro.")
            } else if estacionesBloqueadas.contains(origen) || estacionesBloqueadas.contains(destino) {
                print("❌ El viaje no se puede realizar porque una de las estaciones está cerrada por mantenimiento.")
            } else {
                // Verificar saldo antes de permitir el viaje con la tarifa del sistema
                if miTarjeta.descontar(tarifa: tarifaActual) {
                    let ruta = buscarRuta(origen, destino)
                    print("📍 Ruta óptima encontrada:")
                    print(ruta.joined(separator: " ➡️ "))
                }
            }
            
        case 4:
            // ACCESO AL MODO ADMINISTRADOR
            print("Ingrese la clave de administrador: ", terminator: "")
            let clave = readLine() ?? ""
            
            if clave == CLAVE_ADMIN {
                var enModoAdmin = true
                while enModoAdmin {
                    print("\n🛠️ --- MODO ADMINISTRADOR ---")
                    print("1. Cambiar precio del pasaje (Tarifa actual: S/ \(String(format: "%.2f", tarifaActual)))")
                    print("2. Bloquear/Cerrar una estación")
                    print("3. Desbloquear/Abrir una estación")
                    print("4. Ver estaciones cerradas")
                    print("5. Ver estaciones activas por línea")
                    print("6. Volver al menú de pasajero")
                    print("Seleccione una opción técnica: ", terminator: "")
                    
                    if let entradaAdmin = readLine(), let opcAdmin = Int(entradaAdmin) {
                        switch opcAdmin {
                        case 1:
                            print("Ingrese la nueva tarifa: S/ ", terminator: "")
                            if let entradaTarifa = readLine(), let nuevaTarifa = Double(entradaTarifa), nuevaTarifa >= 0 {
                                tarifaActual = nuevaTarifa
                                print("✅ Tarifa actualizada con éxito a: S/ \(String(format: "%.2f", tarifaActual))")
                            } else {
                                print("❌ Tarifa inválida.")
                            }
                        case 2:
                            print("Ingrese el nombre de la estación a cerrar: ", terminator: "")
                            let est = readLine() ?? ""
                            if estacionALinea[est] != nil {
                                estacionesBloqueadas.insert(est)
                                print("🔒 La estación '\(est)' ha sido cerrada por seguridad.")
                            } else {
                                print("❌ La estación no existe.")
                            }
                        case 3:
                            print("Ingrese el nombre de la estación a reabrir: ", terminator: "")
                            let est = readLine() ?? ""
                            if estacionesBloqueadas.contains(est) {
                                estacionesBloqueadas.remove(est)
                                print("🔓 La estación '\(est)' vuelve a estar operativa.")
                            } else {
                                print("❌ La estación no estaba bloqueada.")
                            }
                        case 4:
                            if estacionesBloqueadas.isEmpty {
                                print("🟢 Todas las estaciones se encuentran operativas en este momento.")
                            } else {
                                print("🚨 Estaciones cerradas: \(estacionesBloqueadas.joined(separator: ", "))")
                            }
                        case 5:
                            print("\n🗺️ --- ESTACIONES ACTIVAS EN LA RED ---")
                            for (linea, estaciones) in lineas {
                                // Filtrar las estaciones que NO están en el conjunto de bloqueadas
                                let activas = estaciones.filter { !estacionesBloqueadas.contains($0) }
                                if activas.isEmpty {
                                    print("⚠️ \(linea): Sin estaciones operativas temporalmente.")
                                } else {
                                    print("🟢 \(linea): \(activas.joined(separator: ", "))")
                                }
                            }
                        case 6:
                            print("Saliendo del modo administrador...")
                            enModoAdmin = false
                        default:
                            print("❌ Opción inválida.")
                        }
                    }
                }
            } else {
                print("❌ Clave incorrecta. Acceso denegado.")
            }
            
        case 5:
            print("\n👋 ¡Gracias por usar el servicio de transporte!")
            ejecutarMenu = false
            
        default:
            print("❌ Opción no válida. Intente del 1 al 5.")
        }
    } else {
        print("❌ Por favor, introduzca un número válido.")
    }
}
