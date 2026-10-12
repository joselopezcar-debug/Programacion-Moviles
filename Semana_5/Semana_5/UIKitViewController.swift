//
//  UIKitViewController.swift
//  Semana_5
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class UIKitViewController: UIViewController {

    // MARK: - Componentes de la Interfaz

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "PROGRAMACIÓN EN MÓVILES AVANZADO" //[cite: 1]
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Interfaces mediante UIKit" //[cite: 1]
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nameBadgeLabel: UILabel = {
        let label = UILabel()
        label.text = "JUAN LEÓN" //[cite: 1, 9]
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(red: 0.45, green: 0.35, blue: 0.12, alpha: 1.0)
        label.backgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.80, alpha: 1.0) // Fondo con color destacado[cite: 9]
        label.textAlignment = .center
        label.layer.cornerRadius = 14
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "UILabel · centradas en Safe Area" //[cite: 11]
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Ciclo de Vida

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Configuración de Auto Layout

    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground

        // Agregar etiquetas al contenedor vertical
        containerStackView.addArrangedSubview(subtitleLabel)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(nameBadgeLabel)
        containerStackView.addArrangedSubview(descriptionLabel)

        view.addSubview(containerStackView)

        // Restricciones de tamaño y centrado en Safe Area[cite: 11, 13]
        NSLayoutConstraint.activate([
            nameBadgeLabel.widthAnchor.constraint(equalToConstant: 220),
            nameBadgeLabel.heightAnchor.constraint(equalToConstant: 54),

            containerStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), //[cite: 11]
            containerStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor), //[cite: 11]
            containerStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}
