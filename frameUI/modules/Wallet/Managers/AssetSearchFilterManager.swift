//
//  AssetSearchFilterManager.swift
//  Tedr
//
//  Created by Kostya Lee on 28/05/25.
//

import Foundation

/// Used in "CurrencySelection" and "WalletSearch"
class AssetSearchFilterManager {
    private(set) var allItems: [WalletAssetRow] = []
    private(set) var filteredItems: [WalletAssetRow] = []
    private(set) var currentFilterIndex: Int = 0
    private(set) var currentSearchText: String = ""
    private(set) var hideZeroBalances = false
    private(set) var sortOption = SortOptions.default
    
    var networkFilters: [String] = []
    
    var onUpdate: (([WalletAssetRow]) -> Void)?

    func configure(items: [WalletAssetRow], filters: [String]) {
        self.allItems = items
        self.networkFilters = filters
        applySearchAndFilter()
    }

    func updateNetworkFilter(index: Int) {
        self.currentFilterIndex = index
        applySearchAndFilter()
    }

    func updateSearch(text: String) {
        self.currentSearchText = text
        applySearchAndFilter()
    }
    
    func hideZeroBalances(_ hide: Bool) {
        self.hideZeroBalances = hide
        applySearchAndFilter()
    }
    
    func sortBy(_ option: SortOptions) {
        sortOption = option
        applySort()
    }
    
    private func applySort() {
        switch sortOption {
        case .balance:
            filteredItems = filteredItems.sorted(by: { $0.amountInUsd > $1.amountInUsd })
        case .name:
            filteredItems = filteredItems.sorted(by: { $0.name > $1.name })
        case .dayChange:
            filteredItems = filteredItems.sorted(by: { $0.name > $1.name })
        case .price:
            filteredItems = filteredItems.sorted(by: { $0.subtitle > $1.subtitle })
        case .default:
            filteredItems = filteredItems.sorted(by: { $0.name > $1.name })
        }
        onUpdate?(filteredItems)
    }

    private func applySearchAndFilter() {
        let filterName = networkFilters[currentFilterIndex]
        let filtered = currentFilterIndex == 0
            ? allItems
            : allItems.filter { $0.network == filterName }

        if currentSearchText.removeSpaces().isEmpty {
            filteredItems = filtered
        } else {
            filteredItems = filtered.filter {
                $0.name.lowercased().contains(currentSearchText.lowercased())
            }
        }
        if hideZeroBalances {
            filteredItems = filteredItems.filter { Double($0.amountInUsd) > 0 }
        }
        onUpdate?(filteredItems)
    }
}
