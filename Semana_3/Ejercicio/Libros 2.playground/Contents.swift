import Foundation

// --- DATOS DE ENTRADA (Primer Commit) ---

print("Ingrese el título del libro:")
let tituloLibro = "Cien años de soledad"

print("Ingrese el tipo de usuario (Alumno, Docente, Admin, Coordinador):")
// Se añade "Coordinador" a las opciones de prueba
let tipoUsuario = "Coordinador"

// Definimos un formato para ingresar las fechas (Año-Mes-Día)
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"

print("Ingrese la fecha de préstamo (AAAA-MM-DD):")
let fechaPrestamoStr = "2026-08-27"
let fechaPrestamo = dateFormatter.date(from: fechaPrestamoStr) ?? Date()

print("Ingrese la fecha de devolución real (AAAA-MM-DD):")
let fechaDevolucionStr = "2026-09-25"
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
case "coordinador": // NUEVO: Reglas de negocio para Coordinador
    diasPermitidos = 15
    tarifaDiaria = 4.0
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
var situacionUsuario = "Activo"

// 5. Calcular la multa acumulativa con la NUEVA escala de recargos por tramos
if diasRetraso > 0 {
    // NUEVO: Suspensión a partir del día 21 (más de 20 días de retraso)
    if diasRetraso > 20 {
        situacionUsuario = "Suspendido"
    }
    
    // Iteramos día por día de retraso para aplicar los nuevos porcentajes
    for dia in 1...diasRetraso {
        var recargo = 1.0 // Tramo 1-3 días: Sin aumento (100% tarifa base)
        
        if dia >= 4 && dia <= 6 {
            recargo = 1.20 // Tramo 4-6 días: +20%
        } else if dia >= 7 && dia <= 10 {
            recargo = 1.50 // Tramo 7-10 días: +50%
        } else if dia >= 11 {
            recargo = 2.00 // Tramo 11-20 días (y posteriores): +100%
        }
        
        multaTotal += tarifaDiaria * recargo
    }
}
