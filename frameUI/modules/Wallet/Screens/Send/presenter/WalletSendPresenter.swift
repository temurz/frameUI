//
//  WalletSendPresenter.swift
//  Tedr
//
//  Created by Kostya Lee on 29/05/25.
//

import Foundation
import UIKit
class WalletSendPresenter: ViewToPresenterWalletSendProtocol {
    weak var view: PresenterToViewWalletSendProtocol?
    var interactor: PresenterToInteractorWalletSendProtocol?
    var router: PresenterToRouterWalletSendProtocol?
    
    var asset: WalletAssetRow {
        didSet {
            transaction.network = asset.network.uppercased()
        }
    }
    var didShowCurrencySelection = false // Show currency selection on start
    
    var transaction = TransactionDetails(
        recipient: User(
            name: "",
            imageURL: ""
        ),
        address: "",
        memo: "",
        network: "",
        fee: "",
        amountToBeSent: "",
        total: ""
    )
    
    private var hasAmountError: Bool = true
    private var hasAddressError: Bool = true
    
    init(asset: WalletAssetRow) {
        self.asset = asset
        transaction.network = asset.network.uppercased()
        transaction.recipient.name = "Kostya Lee" // getCurrentUser().fullName
    }
    
    func handleCallback(_ action: WalletSendController.Action) {
        switch action {
        case .back:
            if let vc = view as? WalletSendController, let navigationController = vc.navigationController {
                self.goBack(navigationController: navigationController)
            }
        case .send(let amount, let address):
            if let vc = view as? WalletSendController {
                self.showTransactionDetails()
            }
        case .amountChanged(let amount):
            self.handleAmountChanged(amount)
        case .addressChanged(let address):
            self.handleAddressChanged(address)
        case .max:
            self.handleMax()
        case .chooseCurrency, .chooseContact:
            break
        case .scan:
            showQRScanner()
        }
    }
    
    private func viewEvent(_ event: WalletSendController.Event) {
        if let controller = view as? WalletSendController {
            controller.receiveEvent(event)
        }
    }
    
    private func validateSendButton() {
        let isValid = !hasAmountError && !hasAddressError
        viewEvent(.setSendButtonEnabled(isValid))
    }

    // update board: if amount is > 0 than show board & values, if amount is 0 then hide board
    // check error with asset.banalce
    // enable send button if no errors & amount is filled & address is valid
    func handleAmountChanged(_ amount: String) {
        let cleaned = amount.replacingOccurrences(of: ",", with: ".")
        
        guard let value = Double(cleaned), value > 0 else {
            hasAmountError = true
            viewEvent(.amountError(error: nil))
            viewEvent(.hideBoard)
            validateSendButton()
            return
        }

        hasAmountError = false

        // Check balance
        if let balance = Double(asset.amountInUsd), value > balance {
            hasAmountError = true
            viewEvent(.amountError(error: Strings.Errors.insufficientBalance))
        } else {
            viewEvent(.amountError(error: nil))
        }

        let fee = value * 0.01 // Will be actually fetched from backend
        transaction.amountToBeSent = String(format: "%.2f USDT", value)
        transaction.fee = String(format: "%.2f USDT", fee)
        transaction.total = String(format: "%.2f USDT", value + fee)

        viewEvent(.updateBoardValues(
            fee: transaction.fee,
            amountToBeSent: transaction.amountToBeSent,
            total: transaction.total
        ))
        
        validateSendButton()
    }

    // check for error: if address is valid
    // enable send button if no errors & amount is filled & address is valid
    func handleAddressChanged(_ address: String) {
        transaction.address = address.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !transaction.address.isEmpty else {
            hasAddressError = true
            viewEvent(.addressError(error: Strings.addressCannotBeEmpty))
            validateSendButton()
            return
        }

        let isValid = isValidAddress(transaction.address, for: asset.name)

        hasAddressError = !isValid

        viewEvent(.addressError(error: isValid ? nil : Strings.Errors.invalid + " \(asset.name.uppercased()) " + Strings.address))

        validateSendButton()
    }
    
    private func isValidAddress(_ address: String, for symbol: String) -> Bool {
        let trimmed = address.trimmingCharacters(in: .whitespacesAndNewlines)

        // Basic checks
        guard !trimmed.isEmpty else { return false }
        guard trimmed.count >= 26 && trimmed.count <= 64 else { return false }

        // Allow only alphanumeric characters (no spaces, emojis, etc.)
        let allowedCharset = CharacterSet.alphanumerics
        return trimmed.rangeOfCharacter(from: allowedCharset.inverted) == nil
    }
    
    private func handleMax() {
        let stringAmount = asset.amountInUsd.replacingOccurrences(of: ",", with: ".")
        let maxValue = stringAmount.toDouble * 0.99
        viewEvent(.updateMaxAmount("\(maxValue)".formatted()))
    }
    
    func sendTransaction(amount: Double, to address: String) {
        interactor?.processTransaction(amount: amount, to: address)
    }
}

// MARK: - Navigation
extension WalletSendPresenter {
    func goBack(navigationController: UINavigationController?) {
        router?.navigateBack(navigationController: navigationController)
    }
    
    func showCurrencySelection() {
        if let view = view as? WalletSendController {
            router?.presentCurrencySelection(view)
        }
    }
    
    func showQRScanner() {
        if let view = view as? WalletSendController {
            router?.presentScanViewController(view)
        }
    }
    
    func showTransactionDetails() {
        if let view = view as? WalletSendController {
            router?.presentTransactionDetails(view, transaction: self.transaction)
        }
    }
}

extension WalletSendPresenter: InteractorToPresenterWalletSendProtocol {
    func transactionSucceeded() {}

    func transactionFailed(error: String) {}
}
