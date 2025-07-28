//
//  WalletReceiveController.swift
//  Tedr
//
//  Created by Kostya Lee on 24/05/25.
//

import Foundation
import UIKit
class WalletReceiveController: TemplateController {
    var presenter: ViewToPresenterWalletReceiveProtocol?
    var mainView: WalletReceiveView?

    let asset: WalletAssetRow
    
    init(asset: WalletAssetRow) {
        self.asset = asset
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialize() {
        self.navigationController?.isNavigationBarHidden = true
        mainView = WalletReceiveView()
        mainView?.cancel = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        view.addSubview(mainView!)

        presenter?.loadQRImage()
    }

    override func updateSubviewsFrames(_ size: CGSize) {
        mainView?.frame = view.bounds
    }
}

extension WalletReceiveController: PresenterToViewWalletReceiveProtocol {
    func show(qrImage: UIImage) {
        mainView?.configure(with: qrImage, asset: asset)
    }
}
