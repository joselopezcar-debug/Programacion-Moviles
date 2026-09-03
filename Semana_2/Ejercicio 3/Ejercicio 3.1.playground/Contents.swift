import UIKit

// ===== EJERCICIO 3: FOR-IN =====

// --- Ejemplo (ya resuelto): ---
for i in 1...5 {
    print("Número: \(i)")
}

// --- TODO 7: Tabla de multiplicar del 7 ---
for i in 1...12 {
    print("7 x \(i) = \(7 * i)")
}

// --- TODO 8: Sumatoria del 1 al 100 ---
var suma = 0
for i in 1...100 {
    suma = suma + i
}
print("La suma del 1 al 100 es: \(suma)") // 5050

// --- TODO 9: Calcular el factorial de 8 ---
var factorial = 1
for i in 1...8 {
    factorial = factorial * i
}
print("8! = \(factorial)") // 40320

// --- TODO 10: Patrón de asteriscos ---
for i in 1...6 {
    print(String(repeating: "*", count: i))
}
