//
//  SettingsAdministratorsViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 24/08/25.
//  
//

import UIKit

class SettingsAdministratorsViewController: TemplateController {
    var mainView: SettingsAdministratorsView?

    // MARK: - Lifecycle Methods
    override func initialize() {
        mainView = SettingsAdministratorsView()
        self.view.addSubview(mainView)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }
    
    

    // MARK: - Properties
    var presenter: ViewToPresenterSettingsAdministratorsProtocol?
    
}

extension SettingsAdministratorsViewController: PresenterToViewSettingsAdministratorsProtocol{
    // TODO: Implement View Output Methods
}
