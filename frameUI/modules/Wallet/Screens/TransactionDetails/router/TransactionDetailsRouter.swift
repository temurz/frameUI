//
//  TransactionDetailsRouter.swift
//  Tedr
//
//  Created by Temur on 30/05/2025.
//  
//

import Foundation
import UIKit

class TransactionDetailsRouter {
    
    // MARK: Static methods
    static func createModule(title: String, details: TransactionDetails, completion: @escaping () -> Void) -> UIViewController {
        let transactionView = TransactionDetailsView()
        transactionView.configure(details: details)
        transactionView.sendAction = {
            completion()
        }
        
        let bottomSheet = ReusableBottomSheetView()
        bottomSheet.setTitle(title)
        bottomSheet.setContentView(transactionView)
        
        let vc = ReusableBottomSheetController(sheetView: bottomSheet)
        return vc
    }
    
}
