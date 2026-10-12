//
//  MainTabBarController.swift
//  Semana_5
//
//  Created by Tecsup on 12/10/26.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        configureTabBarAppearance()
    }

    private func setupTabs() {
        let uikitVC = UIKitViewController()
        uikitVC.tabBarItem = UITabBarItem(title: "UIKit", image: UIImage(systemName: "textformat"), tag: 0)

        let imcVC = UIViewController() // Se reemplazará con la vista de IMC
        imcVC.view.backgroundColor = .systemBackground
        imcVC.tabBarItem = UITabBarItem(title: "IMC", image: UIImage(systemName: "waveform.path.ecg"), tag: 1)

        let prestamoVC = UIViewController() // Se reemplazará con la vista de Préstamo
        prestamoVC.view.backgroundColor = .systemBackground
        prestamoVC.tabBarItem = UITabBarItem(title: "Préstamo", image: UIImage(systemName: "creditcard"), tag: 2)

        let guiaVC = UIViewController() // Se reemplazará con la vista de Guía
        guiaVC.view.backgroundColor = .systemBackground
        guiaVC.tabBarItem = UITabBarItem(title: "Guía", image: UIImage(systemName: "book"), tag: 3)

        viewControllers = [uikitVC, imcVC, prestamoVC, guiaVC]
    }

    private func configureTabBarAppearance() {
        tabBar.tintColor = UIColor(red: 0.12, green: 0.45, blue: 0.38, alpha: 1.0)
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .secondarySystemBackground
    }
}
