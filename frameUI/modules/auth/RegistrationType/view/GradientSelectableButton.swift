//
//  GradientSelectableButton.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//


import UIKit

class GradientSelectableButton: TemplateView {

    enum Style {
        case gradient([CGColor], startPoint: CGPoint, endPoint: CGPoint)
        case filled(UIColor)
    }

    private let button = UIButton(type: .system)
    private var style: Style
    private var cornerRadius: CGFloat
    private var gradientLayer: CAGradientLayer?
    private var currentEnabled: Bool {
        didSet { updateEnabledState() }
    }
    
    init(title: String, style: Style = .gradient([Theme().pinkGradientUpColor.cgColor, Theme().pinkGradientDownColor.cgColor], startPoint: CGPoint(x: 1, y: 0), endPoint: CGPoint(x: 0, y: 1)), cornerRadius: CGFloat = 28, font: UIFont? = Theme().getFont(size: 18, weight: .bold), isEnabled: Bool = true) {
        self.style = style
        self.cornerRadius = cornerRadius
        self.currentEnabled = isEnabled
        super.init(frame: .zero)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initialize() {
        let theme = theme ?? Theme()
        borderRadius = cornerRadius

        button.setTitleColor(theme.whiteColor, for: .normal)
        addSubview(button)
        setEnabled(currentEnabled)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        button.frame = bounds
        gradientLayer?.frame = bounds
        updateEnabledState()
    }

    override func updateTheme() {
        updateEnabledState()
    }

    // MARK: - Public methods

    func setTitle(_ title: String) {
        button.setTitle(title, for: .normal)
    }

    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }
    
    func setEnabled(_ enabled: Bool) {
        currentEnabled = enabled
    }

    //MARK: - Private methods
    private func updateEnabledState() {
        button.isUserInteractionEnabled = currentEnabled
        let theme = theme ?? Theme()
        if currentEnabled {
            // restore style
            switch style {
            case .filled(let color):
                backgroundColor = color
                gradientLayer?.removeFromSuperlayer()
            case .gradient(let colors, let start, let end):
                gradientLayer?.removeFromSuperlayer()
                let gradient = CAGradientLayer()
                gradient.colors = colors
                gradient.startPoint = start
                gradient.endPoint = end
                gradient.cornerRadius = cornerRadius
                layer.insertSublayer(gradient, at: 0)
                gradient.frame = bounds
                gradientLayer = gradient
            }
            button.setTitleColor(theme.whiteColor, for: .normal)
        } else {
            gradientLayer?.removeFromSuperlayer()
            backgroundColor = theme.buttonSecondaryPinkDisabledBg
            button.setTitleColor(theme.buttonSecondaryPinkDisabledContent, for: .normal)
        }
    }

}
