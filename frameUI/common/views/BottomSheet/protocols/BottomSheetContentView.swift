//
//  BottomSheetContentView.swift
//  Tedr
//
//  Created by Temur on 24/05/2025.
//


import UIKit

protocol BottomSheetContentView where Self: UIView {
    func preferredContentHeight() -> CGFloat
}
