//
//  BoletaViewModel.swift
//  Boleta_de_pago
//
//  Created by Tecsup on 27/10/26.
//

import Foundation
import Combine

class BoletaViewModel: ObservableObject {
    // Entradas del Formulario
    @Published var sueldoBasicoText: String = ""
    @Published var diasLaboradosText: String = "30"
    @Published var tieneHijos: Bool = false
    @Published var sistemaPension: SistemaPension = .onp
    @Published var afpSeleccionada: String = "Ejemplo"
    @Published var horas25Text: String = "0"
    @Published var horas35Text: String = "0"
    @Published var adelantosText: String = "0"
    
    // Resultados y errores
    @Published var resultado: ResultadoBoleta? = nil
    @Published var mensajeError: String? = nil
    
    // Diccionario de AFPs disponibles
    let afpsDisponibles: [String: AFPTasas] = [
        "Ejemplo": AFPTasas(nombre: "Ejemplo", fondo: 0.10, comision: 0.016, seguro: 0.0135),
        "Habitat": AFPTasas(nombre: "Habitat", fondo: 0.10, comision: 0.0147, seguro: 0.0135),
        "Prima": AFPTasas(nombre: "Prima", fondo: 0.10, comision: 0.0160, seguro: 0.0135),
        "Integra": AFPTasas(nombre: "Integra", fondo: 0.10, comision: 0.0155, seguro: 0.0135),
        "Profuturo": AFPTasas(nombre: "Profuturo", fondo: 0.10, comision: 0.0169, seguro: 0.0135)
    ]
    
    private func redondear(_ valor: Double) -> Double {
        return (valor * 100.0).rounded() / 100.0
    }
    
    func calcularBoleta() {
        mensajeError = nil
        
        guard let sueldo = Double(sueldoBasicoText), sueldo > 0 else {
            mensajeError = "El sueldo básico debe ser mayor a 0."
            resultado = nil
            return
        }
        
        guard let dias = Int(diasLaboradosText), dias >= 1 && dias <= 30 else {
            mensajeError = "Los días laborados deben estar entre 1 y 30."
            resultado = nil
            return
        }
        
        let h25 = Double(horas25Text) ?? 0.0
        let h35 = Double(horas35Text) ?? 0.0
        let adelantos = Double(adelantosText) ?? 0.0
        
        guard h25 >= 0, h35 >= 0, adelantos >= 0 else {
            mensajeError = "Las horas extras y adelantos deben ser mayores o iguales a 0."
            resultado = nil
            return
        }
        
        // 1. Remuneraciones
        let sueldoComputable = redondear((sueldo / 30.0) * Double(dias))
        let asigFam = tieneHijos ? redondear(ParametrosLaborales.rmv * ParametrosLaborales.porcentajeAsigFam) : 0.0
        
        let valorHora = sueldo / 30.0 / 8.0
        let montoHE25 = redondear(valorHora * 1.25 * h25)
        let montoHE35 = redondear(valorHora * 1.35 * h35)
        
        let remList = [
            ItemBoleta(concepto: "Sueldo computable", monto: sueldoComputable),
            ItemBoleta(concepto: "Asignación familiar", monto: asigFam),
            ItemBoleta(concepto: "Horas extras 25%", monto: montoHE25),
            ItemBoleta(concepto: "Horas extras 35%", monto: montoHE35)
        ]
        
        let totalRem = redondear(remList.reduce(0) { $0 + $1.monto })
        
        // 2. Descuentos
        var descList: [ItemBoleta] = []
        
        if sistemaPension == .onp {
            let onpMonto = redondear(totalRem * ParametrosLaborales.tasaONP)
            descList.append(ItemBoleta(concepto: "ONP (13%)", monto: onpMonto))
            descList.append(ItemBoleta(concepto: "AFP fondo", monto: 0.0))
            descList.append(ItemBoleta(concepto: "AFP comisión", monto: 0.0))
            descList.append(ItemBoleta(concepto: "AFP seguro", monto: 0.0))
        } else {
            descList.append(ItemBoleta(concepto: "ONP", monto: 0.0))
            if let afp = afpsDisponibles[afpSeleccionada] {
                let fMonto = redondear(totalRem * afp.fondo)
                let cMonto = redondear(totalRem * afp.comision)
                let sMonto = redondear(totalRem * afp.seguro)
                
                descList.append(ItemBoleta(concepto: "AFP fondo (\(String(format: "%.2f", afp.fondo * 100))%)", monto: fMonto))
                descList.append(ItemBoleta(concepto: "AFP comisión (\(String(format: "%.2f", afp.comision * 100))%)", monto: cMonto))
                descList.append(ItemBoleta(concepto: "AFP seguro (\(String(format: "%.2f", afp.seguro * 100))%)", monto: sMonto))
            }
        }
        
        descList.append(ItemBoleta(concepto: "Adelantos", monto: adelantos))
        let totalDesc = redondear(descList.reduce(0) { $0 + $1.monto })
        
        // 3. Neto y EsSalud
        let neto = redondear(totalRem - totalDesc)
        let esSaludMonto = redondear(totalRem * ParametrosLaborales.tasaEsSalud)
        
        self.resultado = ResultadoBoleta(
            remuneraciones: remList,
            totalRemuneraciones: totalRem,
            descuentos: descList,
            totalDescuentos: totalDesc,
            netoAPagar: neto,
            esSalud: esSaludMonto
        )
    }
}
