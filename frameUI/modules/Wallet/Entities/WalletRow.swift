//
//  WalletRow.swift
//  Tedr
//
//  Created by Kostya Lee on 13/05/25.
//

import Foundation

struct WalletRow {
    let balance: String
    let growth: String
    let growthPercentage: String
    let assets: [WalletAssetRow]
}
