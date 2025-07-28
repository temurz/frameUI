//
//  WalletHomeController.swift
//  Tedr
//
//  Created by Kostya Lee on 13/05/25.
//

import Foundation
import UIKit
class WalletHomeController: TemplateController {
    var presenter: ViewToPresenterWalletHomeProtocol?
    var mainView: WalletHomeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        show(wallet: WalletRow(balance: "10,720.00 USD", growth: "$26,80", growthPercentage: "3,25%", assets: []))
    }

    override func initialize() {
        self.view.backgroundColor = Theme().backgroundColor

        mainView = WalletHomeView()
        mainView?.sendCallback = { [weak self] in
            guard let asset = allCurrencies.first(where: { $0.name.lowercased() == "usdt" }) else { return }
            self?.presenter?.openSendController(for: asset)
        }
        mainView?.receiveCallback = { [weak self] in
            self?.presenter?.openCurrencySelection(for: .receive)
        }
        mainView?.headerSwapCallback = { [weak self] in
//            self?.presenter.Swap()
        }
        mainView?.headerScanCallback = { [weak self] in
            guard let self else { return }
            presenter?.scan(navigationController)
        }
        mainView?.headerSearchCallback = { [weak self] in
            self?.presenter?.openSearchController()
        }
        self.view.addSubview(mainView!)

        presenter?.loadWallet()
    }

    override func updateSubviewsFrames(_ size: CGSize) {
        mainView?.frame = self.view.bounds
    }
}

extension WalletHomeController: PresenterToViewWalletHomeProtocol {
    func show(wallet: WalletRow) {
        mainView?.configure(with: wallet)
    }
}

extension WalletHomeController: CurrencySelectionDelegate {
    func currencySelected(_ asset: WalletAssetRow) {
        print(asset)
    }
}
