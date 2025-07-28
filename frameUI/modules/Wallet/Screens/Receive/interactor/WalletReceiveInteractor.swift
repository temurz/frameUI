//
//  WalletReceiveInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 24/05/25.
//

import Foundation
import UIKit
class WalletReceiveInteractor: PresenterToInteractorWalletReceiveProtocol {
    weak var presenter: InteractorToPresenterWalletReceiveProtocol?

    func loadQRImage() {
        presenter?.loadedWithQRImage(UIImage(named: "exampleQRImage")!)
    }
}
