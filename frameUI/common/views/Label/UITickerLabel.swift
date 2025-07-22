//
//  UITickerLabel.swift
//  Tedr
//
//  Created by Kostya Lee on 20/05/25.
//

import Foundation
import UIKit
class UITickerLabel: TemplateView {
    
    private var backgroundView: UIView?
    private var tickerLabel: UILabel?
    
    var verticalPadding: CGFloat = 4
    var horizontalPadding: CGFloat = 6
    
    var text: String? {
        get {
            tickerLabel?.text
        }
        set {
            tickerLabel?.text = newValue
        }
    }
    
    override func initialize() {
        backgroundView = UIView()
        self.addSubview(backgroundView)
        
        tickerLabel = UILabel()
        tickerLabel?.font = Theme().getFont(size: 10, weight: .medium)
        tickerLabel?.textAlignment = .center
        self.addSubview(tickerLabel)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        tickerLabel?.sizeToFit()
        let w = tickerLabel?.frame.width ?? 0
        let h = tickerLabel?.frame.height ?? 0
        tickerLabel?.frame = CGRect(x: horizontalPadding, y: verticalPadding, width: w, height: h)
        
        backgroundView?.frame = CGRect(x: 0, y: 0, width: w + horizontalPadding*2, height: h + verticalPadding*2)
        backgroundView?.layer.cornerRadius = 5
    }
    
    func configure(text: String) {
        
        var color = UIColor.systemGray4.withAlphaComponent(0.3)
        let theme = Theme()
        
        switch text.uppercased() {
        case "ETH":
            color = theme.ethereumNetworkColor
        case "BTC", "BITCOIN":
            color = theme.bitcoinNetworkColor
        case "TON":
            color = theme.tonNetworkColor
        case "TRON", "TRX":
            color = theme.tronNetworkColor
        case "FIAT":
            color = theme.fiatNetworkColor
        case "EOS":
            color = theme.eosNetworkColor
        case "BSC":
            color = theme.bscNetworkColor
        default:
            color = .systemGray4
        }
        backgroundView?.backgroundColor = color.withAlphaComponent(0.3)
        tickerLabel?.text = text.uppercased()
        tickerLabel?.textColor = color
    }
    
    func configure(networkType: NetworkType) {
        var color = UIColor.systemGray4.withAlphaComponent(0.3)
        let theme = Theme()
        
        switch networkType {
        case .eth:
            color = theme.ethereumNetworkColor
        case .bitcoin:
            color = theme.bitcoinNetworkColor
        case .ton:
            color = theme.tonNetworkColor
        case .tron:
            color = theme.tronNetworkColor
        case .fiat:
            color = theme.fiatNetworkColor
        case .eos:
            color = theme.eosNetworkColor
        case .bsc:
            color = theme.bscNetworkColor
        }
        backgroundView?.backgroundColor = color.withAlphaComponent(0.3)
        tickerLabel?.text = "\(networkType)".uppercased()
        tickerLabel?.textColor = color
        updateSubviewsFrame(self.size)
    }
    
    func getSize() -> CGSize {
        return CGSize(
            width: tickerLabel?.getWidth() ?? 0 + horizontalPadding*2,
            height: tickerLabel?.height ?? 0 + verticalPadding*2
        )
    }
}
