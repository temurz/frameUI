//
//  ViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 17/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    private let showThemeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Theme Chooser", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(ViewController.self, action: #selector(showThemeChooserTapped), for: .touchUpInside)
        return button
    }()
    
    private let heartButton = BadgeButton(icon: UIImage(named: "heart"))
    private let tagButton = BadgeButton(icon: UIImage(named: "tag"))
    private let arrowButton = BadgeButton(icon: UIImage(named: "arrow"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#3d115f")
        
        view.addSubview(showThemeButton)
        
        heartButton.setBadge(1)
        tagButton.setBadge(1)
        arrowButton.setBadge(22)
        
        view.addSubview(heartButton)
        view.addSubview(tagButton)
        view.addSubview(arrowButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonWidth: CGFloat = 250
        let buttonHeight: CGFloat = 50
        let buttonX = (view.bounds.width - buttonWidth) / 2
        let buttonY = view.safeAreaInsets.top + 30
        showThemeButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        
        let iconSize: CGFloat = 40
        let spacing: CGFloat = 30
        let centerX = view.bounds.midX
        let firstIconY = showThemeButton.frame.maxY + 60
        
        heartButton.frame = CGRect(x: centerX - iconSize / 2, y: firstIconY, width: iconSize, height: iconSize)
        tagButton.frame = CGRect(x: centerX - iconSize / 2, y: heartButton.frame.maxY + spacing, width: iconSize, height: iconSize)
        arrowButton.frame = CGRect(x: centerX - iconSize / 2, y: tagButton.frame.maxY + spacing, width: iconSize, height: iconSize)
    }
    
    @objc func showThemeChooserTapped() {
        let themeVC = ThemeChooserViewController()
        themeVC.presentationPercentage = 0.75
        themeVC.modalPresentationStyle = .overCurrentContext
        themeVC.modalTransitionStyle = .crossDissolve
        present(themeVC, animated: true, completion: nil)
    }
}
