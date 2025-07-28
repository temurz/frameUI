//
//  QRScannerPresenter.swift
//  Tedr
//
//  Created by Temur on 29/05/2025.
//  
//

import Foundation

class QRScannerPresenter: ViewToPresenterQRScannerProtocol {

    // MARK: Properties
    var view: PresenterToViewQRScannerProtocol?
    var interactor: PresenterToInteractorQRScannerProtocol?
    var router: PresenterToRouterQRScannerProtocol?
}

extension QRScannerPresenter: InteractorToPresenterQRScannerProtocol {
    
}
