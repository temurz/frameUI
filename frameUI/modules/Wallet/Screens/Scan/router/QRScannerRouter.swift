//
//  QRScannerRouter.swift
//  Tedr
//
//  Created by Temur on 29/05/2025.
//  
//

import Foundation
import UIKit

class QRScannerRouter: PresenterToRouterQRScannerProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = QRScannerViewController()
        
        let presenter: ViewToPresenterQRScannerProtocol & InteractorToPresenterQRScannerProtocol = QRScannerPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = QRScannerRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = QRScannerInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
