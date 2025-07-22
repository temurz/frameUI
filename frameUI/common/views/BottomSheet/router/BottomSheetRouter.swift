//
//  BottomSheetRoute.swift
//  Tedr
//
//  Created by Temur on 24/05/2025.
//


import UIKit

struct BottomSheetRouter {

    static func makeSheet(with contentView: BottomSheetContentView, title: String) -> UIViewController {
        let sheet = ReusableBottomSheetView()
        sheet.setTitle(title)
        sheet.setContentView(contentView)

        return ReusableBottomSheetController(sheetView: sheet)
    }
}
