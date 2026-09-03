// Desarrollado por: [José Alonso]
// Ejercicio 6 - Gestión de Notas
// Ayuda: Claude

import Foundation

// ===== PASO 1: Pedir número de alumnos CON VALIDACIÓN =====
var cantidadAlumnos = 0
while cantidadAlumnos <= 0 {
    print("¿Cuántos alumnos van a ingresar? (Mínimo 1)")
    let entrada = readLine() ?? ""
    cantidadAlumnos = Int(entrada) ?? 0
    
    if cantidadAlumnos <= 0 {
        print("❌ Error: Debe ingresar al menos 1 alumno")
    }
}

// ===== PASO 2: Crear diccionario para almacenar nombre y notas =====
var alumnosNotas: [String: [Double]] = [:] // Diccionario: clave = nombre, valor = array de 3 notas

// ===== PASO 3: Pedir datos de cada alumno =====
for i in 1...cantidadAlumnos { // Ahora cantidadAlumnos siempre es > 0
    print("\nAlumno \(i) - Nombre:")
    let nombre = readLine() ?? ""
    
    var notas: [Double] = [] // Array temporal para guardar las 3 notas
    
    // ===== PASO 4: Pedir 3 notas con validación =====
    for j in 1...3 {
        var nota = -1.0
        while nota < 0 || nota > 20 {
            print("Nota \(j) (0-20):")
            nota = Double(readLine() ?? "") ?? -1
            
            if nota < 0 || nota > 20 {
                print("❌ Error: La nota debe estar entre 0 y 20")
            }
        }
        notas.append(nota) // Agrega la nota al array temporal
    }
    
    alumnosNotas[nombre] = notas // Guarda el nombre y sus notas en el diccionario principal
}

// ===== PASO 5: Procesar y mostrar resultados =====
print("\n===== REPORTE DE NOTAS =====")

// Variables para estadísticas
var sumaGeneral = 0.0 // Acumula todas las notas de todos los alumnos
var todasLasNotas: [Double] = [] // Array con todas las notas individuales
var aprobados = 0 // Contador de alumnos aprobados
var alumnosConPromedio: [(nombre: String, promedio: Double)] = [] // Array para ordenar

// ===== PASO 6: Calcular promedio de cada alumno =====
for (nombre, notas) in alumnosNotas { // Itera sobre cada alumno en el diccionario
    let suma = notas.reduce(0, +) // Suma las 3 notas usando reduce
    let promedio = suma / Double(notas.count) // Calcula el promedio dividiendo entre 3
    
    // ===== PASO 7: Clasificar con switch =====
    var clasificacion = "" // Variable para guardar la clasificación
    
    // Switch para clasificar según el promedio
    switch promedio {
    case 18...20: // Rango de 18 a 20
        clasificacion = "Excelente"
    case 15..<18: // Rango de 15 a 17.99
        clasificacion = "Bueno"
    case 13..<15: // Rango de 13 a 14.99
        clasificacion = "Aprobado"
    default: // Cualquier otro caso (menor a 13)
        clasificacion = "Desaprobado"
    }
    
    // ===== PASO 8: Mostrar resultado del alumno =====
    print("\(nombre): Promedio = \(String(format: "%.2f", promedio)) - \(clasificacion)")
    
    // ===== PASO 9: Actualizar estadísticas =====
    sumaGeneral += promedio // Suma el promedio al acumulador general
    todasLasNotas.append(contentsOf: notas) // Agrega las notas individuales al array general
    
    // ===== PASO 10: Contar aprobados =====
    if promedio >= 13 { // Si el promedio es mayor o igual a 13
        aprobados += 1 // Incrementa el contador de aprobados
    }
    
    // ===== PASO 11: Guardar para ordenar =====
    alumnosConPromedio.append((nombre: nombre, promedio: promedio))
}

// ===== PASO 12: Mostrar estadísticas generales =====
print("\n===== ESTADÍSTICAS =====")

// Promedio general
let promedioGeneral = sumaGeneral / Double(alumnosNotas.count) // Suma de promedios / cantidad de alumnos
print("Promedio general: \(String(format: "%.2f", promedioGeneral))")

// Nota más alta y más baja
let notaMaxima = todasLasNotas.max() ?? 0 // Encuentra el valor máximo, si falla usa 0
let notaMinima = todasLasNotas.min() ?? 0 // Encuentra el valor mínimo, si falla usa 0
print("Nota más alta: \(notaMaxima)")
print("Nota más baja: \(notaMinima)")

// Porcentaje de aprobados
let porcentajeAprobados = (Double(aprobados) / Double(alumnosNotas.count)) * 100 // Calcula el porcentaje
print("Porcentaje de aprobados: \(String(format: "%.1f", porcentajeAprobados))%")
print("Aprobados: \(aprobados) de \(alumnosNotas.count) alumnos")

// ===== PASO 13: Ordenar por promedio =====
print("\n===== ALUMNOS ORDENADOS POR PROMEDIO =====")

// Ordenar de mayor a menor promedio
alumnosConPromedio.sort { $0.promedio > $1.promedio } // Ordena usando comparación

// Mostrar lista ordenada
for (index, alumno) in alumnosConPromedio.enumerated() { // Itera con índice
    print("\(index + 1). \(alumno.nombre): \(String(format: "%.2f", alumno.promedio))") // Muestra posición, nombre y promedio
}
