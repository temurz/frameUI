//
//  OptionsSheetView.swift
//  Tedr
//
//  Created by Temur on 24/05/2025.
//


import UIKit

enum SortOptions: CaseIterable {
    case balance, name, dayChange, price, `default`

    init?(title: String) {
        for option in SortOptions.allCases {
            if option.title == title {
                self = option
                return
            }
        }
        return nil
    }

    var title: String {
        switch self {
        case .balance: return Strings.balance
        case .name: return Strings.name
        case .dayChange: return Strings._24hChange
        case .price: return Strings.price
        case .default: return Strings.default
        }
    }
}

protocol FilterOptionsSheetViewDelegate: AnyObject {
    func selectedOptions(_ option: SortOptions)
    func hideZeroBalance(_ hide: Bool)
}

class OptionsSheetView: TemplateView {
    let filterLabel = UILabel()
    let hideZeroLabel = UILabel()
    let hideZeroSwitch = UISwitch()
    let sortTitleLabel = UILabel()

    private var options: [String] = SortOptions.allCases.map { $0.title }
    private var rows: [RadioOptionRowView] = []
    private var hideZeroBalances = false

    weak var delegate: FilterOptionsSheetViewDelegate?

    override func initialize() {
        let theme = theme ?? Theme()
        backgroundColor = theme.backgroundTertiaryColor

        filterLabel.text = Strings.filter
        filterLabel.font = theme.getFont(size: 13, weight: .regular)
        filterLabel.textColor = theme.contentSecondary
        addSubview(filterLabel)
        
        hideZeroLabel.text = Strings.hide0Balance
        hideZeroLabel.textColor = theme.whiteColor
        hideZeroLabel.font = theme.getFont(size: 17, weight: .semibold)
        addSubview(hideZeroLabel)
        
        hideZeroSwitch.addTarget(self, action: #selector(hideZeroBalanceAction), for: .valueChanged)
        addSubview(hideZeroSwitch)

        sortTitleLabel.text = Strings.sortBy
        sortTitleLabel.textColor = theme.contentSecondary
        sortTitleLabel.font = theme.getFont(size: 13, weight: .regular)
        addSubview(sortTitleLabel)

        for (index, option) in options.enumerated() {
            let radioOptionRow = RadioOptionRowView(title: option)
            rows.append(radioOptionRow)
            
            radioOptionRow.tag = index
            radioOptionRow.onSelect = { [weak self] in
                self?.radioTapped(index)
            }
            addSubview(radioOptionRow)
        }
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        var x = padding
        var y = padding
        let w = size.width
        var h: CGFloat = 20

        
        filterLabel.frame = .init(x: x, y: y, width: w, height: h)
        
        y = filterLabel.maxY + padding
        hideZeroLabel.frame = CGRect(x: x, y: y, width: w / 2, height: h)
        hideZeroSwitch.frame = CGRect(x: size.width - padding - 50, y: y - 2, width: 50, height: 30)

        y += 40
        sortTitleLabel.frame = CGRect(x: x, y: y, width: w, height: 20)
        
        y += 30
        x = 0
        for row in rows {
            h = 32
            row.frame = CGRect(x: x, y: y, width: w, height: h)
            y += h + 8
        }
    }
    
    @objc private func hideZeroBalanceAction() {
        hideZeroBalances.toggle()
        delegate?.hideZeroBalance(hideZeroBalances)
    }

    private func radioTapped(_ tag: Int) {
        for (index, button) in rows.enumerated() {
            button.isSelected = (tag == index)
        }
        delegate?.selectedOptions(SortOptions(title: options[tag]) ?? .balance)
    }
}

extension OptionsSheetView: BottomSheetContentView {
    func preferredContentHeight() -> CGFloat {
        let padding: CGFloat = 16
        var total: CGFloat = 0
        total += padding // top
        total += 40 // filter
        total += 40 // hide 0
        total += 20 + 10 // sort title
        total += CGFloat(options.count) * (32 + 8)
        total += padding // bottom
        return total
    }
}
