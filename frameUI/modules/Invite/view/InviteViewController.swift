//
//  InviteViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 04/08/25.
//  
//

import UIKit

class InviteViewController: TemplateController {
    var mainView: InviteView?
    var presenter: ViewToPresenterInviteProtocol?

    // MARK: - Lifecycle Methods
    override func initialize() {
        super.initialize()
        
        let view = InviteView(frame: self.view.bounds)
        self.mainView = view
        self.view.addSubview(view)
        
        self.view.backgroundColor = .clear
        self.modalPresentationStyle = .formSheet
        

        view.onButtonTapped = { [weak self] in
            self?.handleButtonTapped()
        }
        
        view.onCancelTapped = { [weak self] in
            self?.handleCancelTapped()
        }
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        super.updateSubviewsFrames(size)
        self.mainView?.frame = self.view.bounds
    }
    
    // MARK: - Actions
    private func handleButtonTapped() {
        print("Main button tapped")

    }
    
    private func handleCancelTapped() {
        print("Cancel tapped")
    }
}

extension InviteViewController: PresenterToViewInviteProtocol {
    // TODO: Implement methods called by the Presenter to update the View
}
