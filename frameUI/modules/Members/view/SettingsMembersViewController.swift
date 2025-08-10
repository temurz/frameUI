//
//  SettingsMembersViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 10/08/25.
//  
//

import UIKit

class SettingsMembersViewController: TemplateController {

    var mainView: SettingsMembersView?
    var presenter: ViewToPresenterSettingsMembersProtocol?

    // MARK: - Lifecycle Methods
    override func initialize() {
        super.initialize()
        
        mainView = SettingsMembersView()
        self.view.addSubview(mainView!)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        super.updateSubviewsFrames(size)
        self.mainView?.frame = self.view.bounds
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
}

extension SettingsMembersViewController : PresenterToViewSettingsMembersProtocol {
    // TODO: Implement methods called by the Presenter to update the View
}
