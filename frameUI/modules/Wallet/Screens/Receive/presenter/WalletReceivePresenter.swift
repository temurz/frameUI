//
//  WalletReceivePresenter.swift
//  Tedr
//
//  Created by Kostya Lee on 24/05/25.
//

import Foundation
import UIKit
class WalletReceivePresenter: ViewToPresenterWalletReceiveProtocol {
    weak var view: PresenterToViewWalletReceiveProtocol?
    var interactor: PresenterToInteractorWalletReceiveProtocol?
    var router: PresenterToRouterWalletReceiveProtocol?

    func loadQRImage() {
        interactor?.loadQRImage()
    }
}

extension WalletReceivePresenter: InteractorToPresenterWalletReceiveProtocol {
    func loadedWithQRImage(_ image: UIImage) {
        view?.show(qrImage: image)
    }
}
