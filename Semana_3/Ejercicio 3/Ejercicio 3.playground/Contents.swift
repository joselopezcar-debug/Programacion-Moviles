// Desarrollado por: [Jospe Alonso]

import Foundation

// ===== TODO 8: Eliminar duplicados =====
var numeros: [Int] = []
for i in 1...8 {
    print("Número \(i):")
    let n = Int(readLine() ?? "") ?? 0
    numeros.append(n)
}
print("Con duplicados: \(numeros)")
let sinDuplicados = Array(Set(numeros)).sorted()
print("Sin duplicados: \(sinDuplicados)")

// ===== TODO 9: Comparar asistencia =====
var lunes: Set<String> = []
var martes: Set<String> = []

print("=== ASISTENCIA LUNES ===")
for i in 1...4 {
    print("Alumno \(i) lunes:")
    let nombre = readLine() ?? ""
    lunes.insert(nombre)
}

print("=== ASISTENCIA MARTES ===")
for i in 1...4 {
    print("Alumno \(i) martes:")
    let nombre = readLine() ?? ""
    martes.insert(nombre)
}

print("\n=== RESULTADOS ===")
print("Ambos días: \(lunes.intersection(martes))")
print("Solo lunes: \(lunes.subtracting(martes))")
print("Solo martes: \(martes.subtracting(lunes))")

// PREDICT
let a: Set = [1, 2, 3, 4, 5]
let b: Set = [4, 5, 6, 7, 8]
print(a.intersection(b)) // PREDICT 5: [4, 5]
print(a.union(b).count) // PREDICT 6: 8
print(a.subtracting(b)) // PREDICT 7: [1, 2, 3]
var repetidos: Set = ["A", "B", "A", "C", "B"]
print(repetidos.count) // PREDICT 8: 3
