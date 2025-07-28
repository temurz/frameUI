//
//  WalletSendController.swift
//  Tedr
//
//  Created by Kostya Lee on 29/05/25.
//

import Foundation
import UIKit

class WalletSendController: TemplateController {
    // Action performed by user
    enum Action {
        case back
        case send(String, String) // Amount, Address
        case amountChanged(String)
        case addressChanged(String)
        case max
        case chooseCurrency
        case scan
        case chooseContact
    }
    
    enum Event {
        case updateCurrency(asset: WalletAssetRow)
        case amountError(error: String?) // Value is nil = there is no error
        case addressError(error: String?)
        case hideBoard // Hide board when entered amount is '0'
        case updateBoardValues(fee: String, amountToBeSent: String, total: String)
        case setSendButtonEnabled(Bool)
        case updateMaxAmount(String)
    }
    
    var presenter: ViewToPresenterWalletSendProtocol?
    var mainView: WalletSendView?

    private let asset: WalletAssetRow
    
    init(asset: WalletAssetRow) {
        self.asset = asset
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.presenter?.showCurrencySelection()
            self?.presenter?.didShowCurrencySelection = true
        }
    }
    
    override func initialize() {
        self.view.backgroundColor = Theme().backgroundColor

        mainView = WalletSendView()
        mainView?.updateCurrency(asset: asset)
        
        mainView?.callback = { [weak self] action in
            self?.presenter?.handleCallback(action)
        }
        
        self.view.addSubview(mainView!)
    }

    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }

    override func reloadContent() {
        mainView?.theme = theme
    }
    
    func receiveEvent(_ event: Event) {
        switch event {
        case .updateCurrency(asset: let asset):
            mainView?.updateCurrency(asset: asset)
        case .amountError(error: let error):
            mainView?.showAmountError(error: error)
        case .addressError(error: let error):
            mainView?.showAddressError(error: error)
        case .hideBoard:
            mainView?.hideBoard(true)
        case let .updateBoardValues(fee: fee, amountToBeSent: amount, total: total):
            mainView?.updateBoardValues(fee: fee, amountToBeSent: amount, total: total)
        case .setSendButtonEnabled(let enable):
            mainView?.setSendButtonEnabled(enable)
        case .updateMaxAmount(let amount):
            mainView?.updateMaxAmount(amount)
        }
        mainView?.updateSubviewsFrames()
    }
}

extension WalletSendController: PresenterToViewWalletSendProtocol {
    func show(asset: WalletAssetRow) {
        
    }
}

extension WalletSendController: CurrencySelectionDelegate {
    func currencySelected(_ asset: WalletAssetRow) {
        mainView?.updateCurrency(asset: asset)
        presenter?.asset = asset
    }
}
