//
//  IMCViewController.swift
//  Semana_5
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class IMCViewController: UIViewController {

    // MARK: - Componentes de la Interfaz

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Encabezado
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "EJERCICIO 02 · CONTROLES BÁSICOS"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 0.12, green: 0.45, blue: 0.38, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calcula tu IMC"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingresa el peso y la altura para probar el cálculo del laboratorio."
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Tarjeta del Formulario
    private let cardContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let formulaBadge: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.12, green: 0.45, blue: 0.38, alpha: 0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "􀍪  IMC = peso ÷ altura²"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 0.12, green: 0.45, blue: 0.38, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
        return view
    }()

    // Campos de Texto (Outlets según la guía del laboratorio)[cite: 17]
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!

    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Peso"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Altura"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        return label
    }()

    // Botón de Cargar Ejemplo
    private lazy var loadExampleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cargar ejemplo: 70 kg y 1.75 m", for: .normal)
        button.setTitleColor(UIColor(red: 0.12, green: 0.45, blue: 0.38, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(cargarEjemplo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Botón Principal de Cálculo
    private lazy var calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calcular resultado   →", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 0.12, green: 0.45, blue: 0.38, alpha: 1.0)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(CalcularResultado(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Tarjeta y Etiqueta de Resultado (Outlet según laboratorio)[cite: 17]
    @IBOutlet weak var resultLabel: UILabel!

    private let resultCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.12, green: 0.45, blue: 0.38, alpha: 0.06)
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.12, green: 0.45, blue: 0.38, alpha: 0.15).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let resultHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "RESULTADO DEL IMC"
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor(red: 0.12, green: 0.45, blue: 0.38, alpha: 0.8)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let resultDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "El resultado y la categoría aparecerán aquí."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let footerDisclaimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Este cálculo es educativo y no sustituye una evaluación médica."
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Ciclo de Vida

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFields()
    }

    // MARK: - Configuración Visual

    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Agregar secciones
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(cardContainerView)
        contentView.addSubview(resultCardView)
        contentView.addSubview(footerDisclaimerLabel)

        // Elementos dentro de la tarjeta del formulario
        cardContainerView.addSubview(formulaBadge)
        
        let weightStack = createInputFieldStack(titleLabel: weightLabel, textField: weightTextField, unitText: "kg")
        let heightStack = createInputFieldStack(titleLabel: heightLabel, textField: heightTextField, unitText: "m")

        cardContainerView.addSubview(weightStack)
        cardContainerView.addSubview(heightStack)
        cardContainerView.addSubview(loadExampleButton)
        cardContainerView.addSubview(calculateButton)

        // Elementos dentro de la tarjeta de resultado
        resultCardView.addSubview(resultHeaderLabel)
        resultCardView.addSubview(resultLabel)
        resultCardView.addSubview(resultDetailLabel)

        // Restricciones de Auto Layout
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),

            // Card Formulario
            cardContainerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            cardContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            formulaBadge.topAnchor.constraint(equalTo: cardContainerView.topAnchor, constant: 16),
            formulaBadge.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 16),

            weightStack.topAnchor.constraint(equalTo: formulaBadge.bottomAnchor, constant: 16),
            weightStack.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 16),
            weightStack.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -16),

            heightStack.topAnchor.constraint(equalTo: weightStack.bottomAnchor, constant: 14),
            heightStack.leadingAnchor.constraint(equalTo: weightStack.leadingAnchor),
            heightStack.trailingAnchor.constraint(equalTo: weightStack.trailingAnchor),

            loadExampleButton.topAnchor.constraint(equalTo: heightStack.bottomAnchor, constant: 12),
            loadExampleButton.leadingAnchor.constraint(equalTo: weightStack.leadingAnchor),
            loadExampleButton.trailingAnchor.constraint(equalTo: weightStack.trailingAnchor),

            calculateButton.topAnchor.constraint(equalTo: loadExampleButton.bottomAnchor, constant: 16),
            calculateButton.leadingAnchor.constraint(equalTo: weightStack.leadingAnchor),
            calculateButton.trailingAnchor.constraint(equalTo: weightStack.trailingAnchor),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            calculateButton.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: -16),

            // Card Resultado
            resultCardView.topAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: 20),
            resultCardView.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor),
            resultCardView.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor),

            resultHeaderLabel.topAnchor.constraint(equalTo: resultCardView.topAnchor, constant: 16),
            resultHeaderLabel.leadingAnchor.constraint(equalTo: resultCardView.leadingAnchor, constant: 16),

            resultLabel.topAnchor.constraint(equalTo: resultHeaderLabel.bottomAnchor, constant: 4),
            resultLabel.leadingAnchor.constraint(equalTo: resultCardView.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: resultCardView.trailingAnchor, constant: -16),

            resultDetailLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 4),
            resultDetailLabel.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor),
            resultDetailLabel.trailingAnchor.constraint(equalTo: resultLabel.trailingAnchor),
            resultDetailLabel.bottomAnchor.constraint(equalTo: resultCardView.bottomAnchor, constant: -16),

            // Footer
            footerDisclaimerLabel.topAnchor.constraint(equalTo: resultCardView.bottomAnchor, constant: 24),
            footerDisclaimerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            footerDisclaimerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            footerDisclaimerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }

    private func setupTextFields() {
        if weightTextField == nil {
            weightTextField = createCustomTextField(placeholder: "Ej. 70")
        }
        if heightTextField == nil {
            heightTextField = createCustomTextField(placeholder: "Ej. 1.75")
        }
        if resultLabel == nil {
            resultLabel = UILabel()
            resultLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            resultLabel.textColor = .label
            resultLabel.text = "El resultado y la categoría aparecerán aquí."
            resultLabel.numberOfLines = 0
            resultLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func createCustomTextField(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.keyboardType = .decimalPad
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        tf.backgroundColor = .systemBackground
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemGray4.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 46))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }

    private func createInputFieldStack(titleLabel: UILabel, textField: UITextField, unitText: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false

        let unitLabel = UILabel()
        unitLabel.text = "\(unitText)  "
        unitLabel.textColor = .tertiaryLabel
        unitLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        unitLabel.sizeToFit()

        textField.rightView = unitLabel
        textField.rightViewMode = .always

        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(textField)
        return stack
    }

    // MARK: - Acciones y Lógica del Laboratorio

    @objc private func cargarEjemplo() {
        weightTextField.text = "70"
        heightTextField.text = "1.75"
    }

    // Acción principal requerida en el laboratorio[cite: 18, 19]
    @IBAction func CalcularResultado(_ sender: Any) {
        // 1. Obtener los valores de peso y altura
        let weight = Double(weightTextField.text ?? "") ?? 0
        let height = Double(heightTextField.text ?? "") ?? 0

        // 2. Verificar si los valores de entrada son válidos
        if weight == 0 || height == 0 {
            resultHeaderLabel.isHidden = true
            resultLabel.text = "Por favor, ingresa valores válidos."[cite: 19]
            resultDetailLabel.text = "Asegúrate de ingresar números mayores a cero."
            return
        }

        // 3. Calcular el IMC (usamos la fórmula estándar: peso / altura²)
        let bmi = weight / (height * height)

        // 4. Determinar si el peso es adecuado según el IMC
        var status = ""
        if bmi < 18.5 {
            status = "Bajo peso"[cite: 14, 19]
        } else if bmi < 24.9 {
            status = "Peso normal"[cite: 14, 19]
        } else if bmi < 29.9 {
            status = "Sobrepeso"[cite: 14, 19]
        } else {
            status = "Obesidad"[cite: 14, 19]
        }

        // 5. Mostrar el resultado
        resultHeaderLabel.isHidden = false
        resultLabel.text = "IMC: \(String(format: "%.2f", bmi)) · \(status)"[cite: 19]
        resultDetailLabel.text = "El resultado está dentro del rango de referencia usado en este ejercicio."
    }
}
