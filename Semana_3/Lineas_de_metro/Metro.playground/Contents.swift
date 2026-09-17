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
