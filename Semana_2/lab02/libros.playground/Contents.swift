import Foundation

// --- DATOS DE ENTRADA (Primer Commit) ---

print("Ingrese el título del libro:")
let tituloLibro = readLine() ?? "Libro Desconocido"

print("Ingrese el tipo de usuario (Alumno, Docente, Admin):")
let tipoUsuario = readLine() ?? "Alumno"

// Definimos un formato para ingresar las fechas (Año-Mes-Día)
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"

print("Ingrese la fecha de préstamo (AAAA-MM-DD):")
let fechaPrestamoStr = readLine() ?? ""
let fechaPrestamo = dateFormatter.date(from: fechaPrestamoStr) ?? Date()

print("Ingrese la fecha de devolución real (AAAA-MM-DD):")
let fechaDevolucionStr = readLine() ?? ""
let fechaDevolucion = dateFormatter.date(from: fechaDevolucionStr) ?? Date()


// --- LÓGICA DE MULTAS Y PLAZOS (Segundo Commit) ---

// 1. Determinar días permitidos y tarifa diaria según el usuario
var diasPermitidos = 0
var tarifaDiaria = 0.0

switch tipoUsuario.lowercased() {
case "alumno":
    diasPermitidos = 7
    tarifaDiaria = 1.5
case "docente":
    diasPermitidos = 15
    tarifaDiaria = 2.0
case "admin":
    diasPermitidos = 10
    tarifaDiaria = 3.0
default:
    diasPermitidos = 7
    tarifaDiaria = 1.5
}

// 2. Calcular la fecha límite de entrega
let calendario = Calendar.current
let fechaLimite = calendario.date(byAdding: .day, value: diasPermitidos, to: fechaPrestamo) ?? Date()

// 3. Calcular los días transcurridos entre el préstamo y la devolución real
let componentes = calendario.dateComponents([.day], from: fechaPrestamo, to: fechaDevolucion)
let diasTotalesPrestamo = componentes.day ?? 0

// 4. Calcular días de retraso
let diasRetraso = max(0, diasTotalesPrestamo - diasPermitidos)

// Variables para el resultado final
var multaTotal = 0.0
var situacionUsuario = "habilitado"

// 5. Calcular la multa acumulativa con recargos por tramos
if diasRetraso > 0 {
    if diasRetraso >= 10 {
        situacionUsuario = "Suspendido"
    }
    
    // Iteramos día por día de retraso para aplicar el aumento acumulativo con su recargo
    for dia in 1...diasRetraso {
        var recargo = 1.0 // 100% de la tarifa normal
        
        if dia >= 4 && dia <= 6 {
            recargo = 1.5 // 50% adicional
        } else if dia >= 7 && dia <= 9 {
            recargo = 2.0 // 100% adicional
        } else if dia >= 10 {
            recargo = 2.0 // Mantiene el recargo máximo tras el día 10 (además de la suspensión)
        }
        
        multaTotal += tarifaDiaria * recargo
    }
}

// --- SALIDA DE DATOS (Tercer Commit) ---

// Formateador para mostrar las fechas de manera amigable
let formatoSalida = DateFormatter()
formatoSalida.dateStyle = .medium
formatoSalida.locale = Locale(identifier: "es_ES")

let estadoDevolucion = diasRetraso > 0 ? "Con atraso" : "A tiempo"

print("\n================ RESUMEN DE DEVOLUCIÓN ================")
print("📘 Libro: \(tituloLibro)")
print("👤 Tipo de Usuario: \(tipoUsuario.capitalized)")
print("📅 Fecha de Préstamo: \(formatoSalida.string(from: fechaPrestamo))")
print("⏳ Fecha Límite: \(formatoSalida.string(from: fechaLimite))")
print("📆 Fecha de Devolución: \(formatoSalida.string(from: fechaDevolucion))")
print("🛑 Días de Atraso: \(diasRetraso) día(s)")
print("💰 Multa Total: $\(String(format: "%.2f", multaTotal))")
print("📋 Estado de Devolución: \(estadoDevolucion)")
print("⚠️ Situación del Usuario: \(situacionUsuario)")
print("=======================================================")
