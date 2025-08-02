//
//  SettingsAdminViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 30/07/25.
//

import UIKit

class SettingsAdminViewController: TemplateController {
    private var mainView: SettingsAdminView?
    var presenter: ViewToPresenterSettingsAdminProtocol?
    
    // MARK: - Lifecycle Methods
    override func initialize() {
        super.initialize()
        
        let view = SettingsAdminView(frame: self.view.bounds)
        self.mainView = view
        self.view.addSubview(view)
        
        // Bind button actions
        view.onCancelTapped = { [weak self] in
            self?.cancelButtonTapped()
        }
        
        view.onSaveTapped = { [weak self] in
            self?.saveButtonTapped()
        }
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        super.updateSubviewsFrames(size)
        self.mainView?.frame = self.view.bounds
    }
    
    // MARK: - Actions
    private func cancelButtonTapped() {
        print("Cancel tapped")
        // Example: presenter?.handleCancel()
    }
    
    private func saveButtonTapped() {
        print("Save tapped")
        // Example: presenter?.handleSave()
    }
}

extension SettingsAdminViewController: PresenterToViewSettingsAdminProtocol {
    // TODO: Implement methods called by the Presenter to update the View
}
