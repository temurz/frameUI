//
//  WalletAssetRow.swift
//  Tedr
//
//  Created by Kostya Lee on 13/05/25.
//

import Foundation
import UIKit

struct WalletAssetRow {
    let icon: String // The name of image which will be pulled from Assets
    let name: String
    let subtitle: String
    let amountInUsd: String
    let network: String
}

let allCurrencies = [
    WalletAssetRow(icon: "usdt", name: "usdt", subtitle: "", amountInUsd: "0.999", network: "eth"),
    WalletAssetRow(icon: "usdc", name: "usdc", subtitle: "", amountInUsd: "0.998", network: "eth"),
    WalletAssetRow(icon: "eth", name: "eth", subtitle: "", amountInUsd: "2485", network: "eth"),
    WalletAssetRow(icon: "cnht", name: "cnht", subtitle: "", amountInUsd: "1.0", network: "fiat"),
    WalletAssetRow(icon: "eurt", name: "eurt", subtitle: "", amountInUsd: "1.0", network: "bsc"),
    WalletAssetRow(icon: "dai", name: "dai", subtitle: "", amountInUsd: "1.0", network: "bitcoin"),
    WalletAssetRow(icon: "shib", name: "shib", subtitle: "", amountInUsd: "0.00001425", network: "bsc"),
    WalletAssetRow(icon: "matic", name: "matic", subtitle: "", amountInUsd: "0.2323", network: "eth"),
    WalletAssetRow(icon: "cro", name: "cro", subtitle: "", amountInUsd: "0.0982", network: "eos"),
    WalletAssetRow(icon: "link", name: "link", subtitle: "", amountInUsd: "15.37", network: "eos"),
    WalletAssetRow(icon: "wbtc", name: "wbtc", subtitle: "", amountInUsd: "102783", network: "bitcoin"),
    WalletAssetRow(icon: "busd", name: "busd", subtitle: "", amountInUsd: "0.9870", network: "bitcoin"),
    WalletAssetRow(icon: "mkr", name: "mkr", subtitle: "", amountInUsd: "1752.51", network: "fiat"),
    WalletAssetRow(icon: "teuro", name: "teuro", subtitle: "", amountInUsd: "1.0", network: "eos"),
    WalletAssetRow(icon: "ustt", name: "ustt", subtitle: "", amountInUsd: "1.0", network: "eth"),
    WalletAssetRow(icon: "austt", name: "austt", subtitle: "", amountInUsd: "1.0", network: "eth"),
    WalletAssetRow(icon: "gold", name: "gold", subtitle: "", amountInUsd: "1.0", network: "fiat"),
    WalletAssetRow(icon: "bnb", name: "bnb", subtitle: "", amountInUsd: "642.15", network: "eth"),
    WalletAssetRow(icon: "corn", name: "corn", subtitle: "", amountInUsd: "2.0", network: "tron"),
    WalletAssetRow(icon: "trx", name: "trx", subtitle: "", amountInUsd: "0.2685", network: "tron"),
    WalletAssetRow(icon: "btc", name: "btc", subtitle: "", amountInUsd: "82400", network: "bitcoin"),
    WalletAssetRow(icon: "not", name: "not", subtitle: "", amountInUsd: "", network: "ton"),
    WalletAssetRow(icon: "ton", name: "ton", subtitle: "", amountInUsd: "", network: "ton"),
    WalletAssetRow(icon: "usd", name: "usd", subtitle: "", amountInUsd: "1.00", network: "fiat"),
    WalletAssetRow(icon: "eur", name: "eur", subtitle: "", amountInUsd: "1.0", network: "fiat"),
    WalletAssetRow(icon: "gbp", name: "gbp", subtitle: "", amountInUsd: "1.3283", network: "fiat"),
    WalletAssetRow(icon: "jpy", name: "jpy", subtitle: "", amountInUsd: "0.006867", network: "fiat"),
    WalletAssetRow(icon: "ausdt", name: "ausdt", subtitle: "", amountInUsd: "1.0", network: "eth"),
    WalletAssetRow(icon: "ada", name: "ada", subtitle: "", amountInUsd: "0.7606", network: "eth"),
    WalletAssetRow(icon: "lnbitcoin", name: "lnbitcoin", subtitle: "", amountInUsd: "90892", network: "bitcoin"),
    WalletAssetRow(icon: "xaut", name: "xaut", subtitle: "", amountInUsd: "3206.00", network: "fiat")
]
