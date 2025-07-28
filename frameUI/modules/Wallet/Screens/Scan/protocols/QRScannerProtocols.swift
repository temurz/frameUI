//
//  QRScannerProtocols.swift
//  Tedr
//
//  Created by Temur on 29/05/2025.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewQRScannerProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterQRScannerProtocol {
    
    var view: PresenterToViewQRScannerProtocol? { get set }
    var interactor: PresenterToInteractorQRScannerProtocol? { get set }
    var router: PresenterToRouterQRScannerProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorQRScannerProtocol {
    
    var presenter: InteractorToPresenterQRScannerProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterQRScannerProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterQRScannerProtocol {
    
}
