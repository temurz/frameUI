//
//  ChooseThemeViewController.swift
//  Tedr
//
//  Created by Temur on 26/07/2025.
//  
//

import UIKit

class ChooseThemeViewController: TemplateController {
    var mainView: ThemeChooserView?

    // MARK: - Lifecycle Methods
    override func initialize() {
        self.view.backgroundColor = .clear
        mainView = ThemeChooserView()
        mainView?.dismiss = { [weak self] in
            self?.dismiss(animated: true)
        }
        self.view.addSubview(mainView)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }
    
    

    // MARK: - Properties
    var presenter: ViewToPresenterChooseThemeProtocol?
    
}

extension ChooseThemeViewController: PresenterToViewChooseThemeProtocol{
    // TODO: Implement View Output Methods
}
