//
//  TemplateView.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//
import Foundation
import UIKit
protocol Deinitable: AnyObject {
    func deinitValues()
}
class TemplateView: UIView, Deinitable {
    var theme: Theme? {
        didSet {
            updateTheme()
        }
    }
    var framesSetted = false
    let screenWidth = UIScreen.main.bounds.width
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        isAccessibilityElement = false
        accessibilityElementsHidden = true
        
        initialize()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: NSNotification.Name("updateTheme"), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var frame: CGRect {
        didSet {
            if bounds.size.width == 0 && bounds.size.height == 0 {
                return
            }
            self.updateSubviewsFrames()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func updateSubviewsFrames() {
        self.updateSubviewsFrame(self.bounds.size)
    }
    
    func initialize() {
        
    }
    
    func updateSubviewsFrame(_ size: CGSize) {
        
    }
    
    @objc func updateTheme() {}
    
    func deinitValues() {
        removeAllSubviews()
    }
}
