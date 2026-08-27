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
