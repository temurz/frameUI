//
//  ContextMenu.swift
//  Tedr
//
//  Created by Temur on 29/06/2025.
//

import UIKit

class ContextMenu: TemplateView {
    private var items: [ContextItem] = []
    var bgView: UIView?
    
    var action: ((Int) -> Void)?
    
    override func initialize() {
        backgroundColor = Theme().backgroundTertiaryColor
        bgView = UIView()
        self.addSubview(bgView)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let h = CGFloat(items.count * 40)
        bgView?.frame = .init(x: 0, y: 8, width: size.width, height: h)
    }
    
    private func addButtons(_ items: [ContextItem]) {
        let buttonHeight: CGFloat = 40
        
        for (index, item) in items.enumerated() {
            let button = UIButton()
            button.setTitle(item.title, for: .normal)
            button.setTitleColor(item.color, for: .normal)
            button.setImage(item.image?.withTintColor(item.color), for: .normal)
            button.tintColor = item.color
            button.contentHorizontalAlignment = .left
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.tag = index
            button.frame = CGRect(x: 0, y: CGFloat(index) * buttonHeight, width: width, height: buttonHeight)
            button.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
            
            bgView?.addSubview(button)
        }
    }
    
    @objc private func handleTap(_ sender: UIButton) {
        action?(sender.tag)
    }
    
    private func selectItem(at tag: Int) {
        
    }
    
    func setItems(_ items: [ContextItem]) {
        self.items = items
        addButtons(items)
        updateSubviewsFrame(self.size)
    }
    
    func getHeight() -> CGFloat {
        let height = (items.count * 40) + 16
        return CGFloat(height)
    }
}
