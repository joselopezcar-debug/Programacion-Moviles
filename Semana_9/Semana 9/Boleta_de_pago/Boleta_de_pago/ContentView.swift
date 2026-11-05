//
//  ContentView.swift
//  Boleta_de_pago
//
//  Created by Tecsup on 27/10/26.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BoletaViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                VStack(alignment: .center, spacing: 4) {
                    Text("Boleta de ejemplo")
                        .font(.title2)
                        .bold()
                    Text("Cálculo de Sueldo Neto")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
                
                // Formulario de entrada
                Group {
                    Text("Datos de entrada")
                        .font(.headline)
                    
                    HStack {
                        Text("Sueldo básico (S/):")
                        Spacer()
                        TextField("Ej. 2500.00", text: $viewModel.sueldoBasicoText)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 130)
                    }
                    
                    HStack {
                        Text("Días laborados:")
                        Spacer()
                        TextField("1 - 30", text: $viewModel.diasLaboradosText)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 130)
                    }
                    
                    Picker("¿Tiene hijos?", selection: $viewModel.tieneHijos) {
                        Text("No").tag(false)
                        Text("Sí").tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Sistema de Pensiones", selection: $viewModel.sistemaPension) {
                        ForEach(SistemaPension.allCases) { sys in
                            Text(sys.rawValue).tag(sys)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if viewModel.sistemaPension == .afp {
                        HStack {
                            Text("Seleccionar AFP:")
                            Spacer()
                            Picker("AFP", selection: $viewModel.afpSeleccionada) {
                                ForEach(Array(viewModel.afpsDisponibles.keys.sorted()), id: \.self) { key in
                                    Text(key).tag(key)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("Horas extras 25%:")
                        Spacer()
                        TextField("0", text: $viewModel.horas25Text)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Horas extras 35%:")
                        Spacer()
                        TextField("0", text: $viewModel.horas35Text)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Adelantos (S/):")
                        Spacer()
                        TextField("0.00", text: $viewModel.adelantosText)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                    }
                }
                
                if let error = viewModel.mensajeError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .bold()
                }
                
                Button(action: {
                    viewModel.calcularBoleta()
                }) {
                    Text("Calcular Boleta")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.vertical, 8)
                
                // Vista de Boleta Resultante
                if let res = viewModel.resultado {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("BOLETA DE PAGO")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        // 1. Remuneraciones
                        Text("REMUNERACIONES")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.blue)
                        
                        ForEach(res.remuneraciones) { item in
                            HStack {
                                Text(item.concepto)
                                Spacer()
                                Text(String(format: "%.2f", item.monto))
                            }
                        }
                        HStack {
                            Text("Total Remuneraciones")
                                .bold()
                            Spacer()
                            Text(String(format: "%.2f", res.totalRemuneraciones))
                                .bold()
                        }
                        .padding(.top, 4)
                        
                        Divider()
                        
                        // 2. Retenciones / Descuentos
                        Text("RETENCIONES / DESCUENTOS")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.red)
                        
                        ForEach(res.descuentos) { item in
                            HStack {
                                Text(item.concepto)
                                Spacer()
                                Text(String(format: "%.2f", item.monto))
                            }
                        }
                        HStack {
                            Text("Total Descuentos")
                                .bold()
                            Spacer()
                            Text(String(format: "%.2f", res.totalDescuentos))
                                .bold()
                        }
                        .padding(.top, 4)
                        
                        Divider()
                        
                        // 3. Aportaciones Empleador
                        Text("APORTACIONES DEL EMPLEADOR")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.orange)
                        
                        HStack {
                            Text("EsSalud (9%)")
                            Spacer()
                            Text(String(format: "%.2f", res.esSalud))
                        }
                        
                        Divider()
                        
                        // Total Neto
                        HStack {
                            Text("NETO A PAGAR:")
                                .font(.title3)
                                .bold()
                            Spacer()
                            Text("S/ \(String(format: "%.2f", res.netoAPagar))")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.green)
                        }
                        .padding(.vertical, 8)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
