import UIKit

// ===== FIX: Encuentra los 2 errores =====

// FIX 4: Cambiar i % 2 == 1 a i % 2 == 0 para pares
for i in 1...20 {
    if i % 2 == 0 {
        print(i)
    }
}

// FIX 5: Usar stride para cuenta regresiva
for i in stride(from: 10, through: 1, by: -1) {
    print(i)
}
