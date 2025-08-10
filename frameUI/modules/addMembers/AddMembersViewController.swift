//
//  AddMembersViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 11/08/25.
//  
//

import UIKit

class AddMembersViewController: TemplateController {
    var mainView: AddMembersView?

    // MARK: - Lifecycle Methods
    override func initialize() {
        mainView = AddMembersView()
        self.view.addSubview(mainView)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }
    
    

    // MARK: - Properties
    var presenter: ViewToPresenterAddMembersProtocol?
    
}

extension AddMembersViewController: PresenterToViewAddMembersProtocol{
    // TODO: Implement View Output Methods
}
