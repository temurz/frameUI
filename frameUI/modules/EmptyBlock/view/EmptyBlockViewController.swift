//
//  EmptyBlockViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import UIKit

class EmptyBlockViewController: TemplateController {
    var mainView: EmptyBlockView?

    // MARK: - Lifecycle Methods
    override func initialize() {
        mainView = EmptyBlockView()
        self.view.addSubview(mainView)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        super.updateSubviewsFrames(size)
        self.mainView?.frame = self.view.bounds
    }
    
    

    // MARK: - Properties
    var presenter: ViewToPresenterEmptyBlockProtocol?
    
}

extension EmptyBlockViewController: PresenterToViewEmptyBlockProtocol{
    // TODO: Implement View Output Methods
}
