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
