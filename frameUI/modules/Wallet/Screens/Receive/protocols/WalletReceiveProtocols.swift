//
//  WalletReceiveProtocols.swift
//  Tedr
//
//  Created by Kostya Lee on 24/05/25.
//

import Foundation
import UIKit

protocol ViewToPresenterWalletReceiveProtocol: AnyObject {
    var view: PresenterToViewWalletReceiveProtocol? { get set }
    var interactor: PresenterToInteractorWalletReceiveProtocol? { get set }
    var router: PresenterToRouterWalletReceiveProtocol? { get set }
    func loadQRImage()
}

protocol PresenterToViewWalletReceiveProtocol: AnyObject {
    func show(qrImage: UIImage)
}

protocol PresenterToInteractorWalletReceiveProtocol: AnyObject {
    var presenter: InteractorToPresenterWalletReceiveProtocol? { get set }
    func loadQRImage()
}

protocol InteractorToPresenterWalletReceiveProtocol: AnyObject {
    func loadedWithQRImage(_ image: UIImage)
}

protocol PresenterToRouterWalletReceiveProtocol: AnyObject {
    static func createModule(asset: WalletAssetRow) -> WalletReceiveController
}
