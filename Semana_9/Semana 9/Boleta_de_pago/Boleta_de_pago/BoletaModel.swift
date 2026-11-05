//
//  BoletaModel.swift
//  Boleta_de_pago
//
//  Created by Tecsup on 27/10/26.
//

import Foundation

// Parametros constantes globales del sistema
struct ParametrosLaborales {
    static let rmv: Double = 1230.00
    static let porcentajeAsigFam: Double = 0.10
    static let tasaONP: Double = 0.13
    static let tasaEsSalud: Double = 0.09
}

enum SistemaPension: String, CaseIterable, Identifiable {
    case onp = "ONP"
    case afp = "AFP"
    var id: String { self.rawValue }
}

struct AFPTasas {
    let nombre: String
    let fondo: Double
    let comision: Double
    let seguro: Double
}

struct ItemBoleta: Identifiable {
    let id = UUID()
    let concepto: String
    let monto: Double
}

struct ResultadoBoleta {
    let remuneraciones: [ItemBoleta]
    let totalRemuneraciones: Double
    let descuentos: [ItemBoleta]
    let totalDescuentos: Double
    let netoAPagar: Double
    let esSalud: Double
}
