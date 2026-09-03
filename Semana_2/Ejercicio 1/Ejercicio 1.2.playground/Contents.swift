import Foundation

// ===== FIX: Encuentra y corrige los 3 errores =====

// Error 1: faltaba un paréntesis después del if
let temperatura = 35
if temperatura > 30 {
    print("Hace calor")
} else if temperatura > 20 {
    print("Clima agradable")
} else {
    print("Hace frío")
}

// Error 2: en la impresión se usa \(saldo - compra) pero el saldo es menor que compra
let saldo = 100.0
let compra = 150.0
if saldo >= compra {  // Cambiar > por >= para que funcione correctamente
    print("Compra realizada")
} else {
    print("Saldo insuficiente: te faltan \(compra - saldo)") // Cambiar saldo - compra por compra - saldo
}

// Error 3: hora = 25 es inválida, pero funciona correctamente
let hora = 25
if hora >= 0 && hora < 12 {
    print("Buenos días")
} else if hora >= 12 && hora < 18 {
    print("Buenas tardes")
} else if hora >= 18 && hora <= 23 {
    print("Buenas noches")
} else {
    print("Hora inválida")
}
