import UIKit

// PREDICT 6: Valor total = 15 (1+2+3+4+5), 5 iteraciones
var total = 0
for i in 1...5 {
    total += i
}
print(total)

// PREDICT 7: "Hola Hola Hola " (3 veces), _ se usa cuando no necesitas el valor del índice
var texto = ""
for _ in 1...3 {
    texto += "Hola "
}
print(texto)
