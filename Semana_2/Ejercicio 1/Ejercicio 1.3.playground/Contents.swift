import Foundation

// PREDICT 1: "Dentro del rango" (x=10 está entre 5 y 20)
let x = 10
if x > 5 && x < 20 {
    print("Dentro del rango")
} else {
    print("Fuera del rango")
}

// PREDICT 2: "Mayor que 10" - No imprime "Mayor que 5" porque la condición y>10 se cumple primero y el else if se detiene al encontrar la primera condición verdadera
let y = 15
if y > 20 {
    print("Mayor que 20")
} else if y > 10 {
    print("Mayor que 10")
} else if y > 5 {
    print("Mayor que 5")
}

// PREDICT 3: "Es lunes O llueve" - porque esLunes es true, aunque llueve sea false, la condición OR se cumple
let esLunes = true
let llueve = false
if esLunes && llueve {
    print("Lunes lluvioso")
} else if esLunes || llueve {
    print("Es lunes O llueve")
} else {
    print("Ni lunes ni llueve")
}
