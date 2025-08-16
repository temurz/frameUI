//
//  BlockedUserViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import UIKit

class BlockedUserViewController: TemplateController {
    var mainView: BlockedUserView?

    // MARK: - Lifecycle Methods
    override func initialize() {
        mainView = BlockedUserView()
        self.view.addSubview(mainView)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }
    
    

    // MARK: - Properties
    var presenter: ViewToPresenterBlockedUserProtocol?
    
}

extension BlockedUserViewController: PresenterToViewBlockedUserProtocol{
    // TODO: Implement View Output Methods
}
