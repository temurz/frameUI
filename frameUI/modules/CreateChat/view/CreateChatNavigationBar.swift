//
//  CreateChatNavigationBar.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//

import UIKit

class CreateChatNavigationBar: TemplateView {
    private let dragIndicator = UIView()
    private let cancelButton = UIButton()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nextButton = UIButton()
    private let barContainer = UIView()
    
    var didSelectBackButton: (() -> Void)?
    var didSelectNextButton: (() -> Void)?
    
    override func initialize() {
        let theme = theme ?? Theme()
        
        dragIndicator.backgroundColor = theme.contentSecondary
        dragIndicator.borderRadius = 4
        self.addSubview(dragIndicator)
        
        barContainer.backgroundColor = .clear
        self.addSubview(barContainer)
        
        cancelButton.setTitle(Strings.cancel, for: .normal)
        cancelButton.setTitleColor(theme.contentSecondary, for: .normal)
        cancelButton.addTapGesture(tapNumber: 1) { [weak self] _ in
            self?.didSelectBackButton?()
        }
        barContainer.addSubview(cancelButton)
        
        titleLabel.text = "New message"
        titleLabel.textColor = theme.contentPrimary
        titleLabel.font = .onest(.bold, size: 18)
        barContainer.addSubview(titleLabel)
        
        subtitleLabel.text = "0 members"
        subtitleLabel.textColor = theme.contentPrimary
        subtitleLabel.font = .onest(size: 13)
        subtitleLabel.isHidden = true
        barContainer.addSubview(subtitleLabel)
        
        nextButton.setTitleColor(theme.contentPink, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .onest(.semiBold, size: 16)
        nextButton.addTapGesture(tapNumber: 1) { [weak self] _ in
            self?.didSelectNextButton?()
        }
        nextButton.isHidden = true
        barContainer.addSubview(nextButton)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        let barHeight: CGFloat = 44
        var w: CGFloat = 40
        var h: CGFloat = 5
        var x = (size.width - w) / 2
        var y: CGFloat = 0
        self.dragIndicator.frame = .init(x: x, y: y, width: w, height: h)
        
        x = 0
        y = dragIndicator.maxY + 6
        w = size.width
        h = barHeight
        self.barContainer.frame = .init(x: x, y: y, width: w, height: h)
        
        x = padding
        w = size.width/4 - (padding*2)
        h = cancelButton.titleLabel?.textHeight(w) ?? 20
        y = (barHeight - h)/2
        self.cancelButton.frame = .init(x: x, y: y, width: w, height: h)
        
        w = titleLabel.getWidth()
        w = min(size.width/2, w)
        h = titleLabel.textHeight(w)
        x = (size.width - w) / 2
        y = subtitleLabel.isHidden ? (barHeight - h) / 2 : barHeight/2 - h
        self.titleLabel.frame = .init(x: x, y: y, width: w, height: h)
        
        w = subtitleLabel.getWidth()
        w = min(size.width/2, w)
        y = titleLabel.maxY
        x = (size.width - w) / 2
        h = subtitleLabel.textHeight(w)
        self.subtitleLabel.frame = .init(x: x, y: y, width: w, height: h)
        
        w = size.width / 4 - (padding*2)
        x = size.width - w - padding
        h = nextButton.titleLabel?.textHeight(w) ?? 20
        y = (barHeight - h) / 2
        self.nextButton.frame = .init(x: x, y: y, width: w, height: h)
    }
    
    func updateNavBar(step: CreateChatStep) {
        switch step {
        case .newMessage:
            titleLabel.text = "New message"
            cancelButton.setTitle(Strings.cancel, for: .normal)
            subtitleLabel.isHidden = true
            nextButton.isHidden = true
        case .addMembers:
            titleLabel.text = "Add members"
            cancelButton.setTitle("Back", for: .normal)
            subtitleLabel.isHidden = false
            nextButton.isHidden = false
            nextButton.setTitle("Next", for: .normal)
        case .createGroup:
            titleLabel.text = "New group"
            cancelButton.setTitle("Back", for: .normal)
            subtitleLabel.isHidden = true
            nextButton.isHidden = false
            nextButton.setTitle("Create", for: .normal)
        }
        updateSubviewsFrame(self.size)
    }
}
