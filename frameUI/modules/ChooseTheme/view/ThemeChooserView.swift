//
//  ThemeChooserView.swift
//  Tedr
//
//  Created by Temur on 26/07/2025.
//



import CoreFoundation
import UIKit

class ThemeChooserView: TemplateView {

    var presentationPercentage: CGFloat = 0.75
    private var contentView: UIView = UIView()
    private var initialContentY: CGFloat = 0
    
    var dismiss: (() -> Void)?

    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme().contentSecondary
        view.borderRadius = 2.5
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose theme"
        return label
    }()

    private lazy var segmentedControl: SegmentedControl = {
        let control = SegmentedControl(items: ["Theme", "Background"], cornerRadius: 22)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return control
    }()

    private let backgroundsLabel: UILabel = {
        let label = UILabel()
        label.text = "CHAT BACKGROUNDS"
        return label
    }()

    private let backgroundsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private let patternsLabel: UILabel = {
        let label = UILabel()
        label.text = "CHAT PATTERNS"
        return label
    }()

    private let patternsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let applyButton = GradientSelectableButton(title: "Apply", cornerRadius: 25)

    override func initialize() {
        let theme = theme ?? Theme()
        contentView.backgroundColor = theme.backgroundTertiaryColor
        contentView.borderRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addSubview(contentView)
        
        segmentedControl.backgroundColor = theme.bgBlackTransparent20
        segmentedControl.selectedSegmentTintColor = theme.backgroundSecondaryColor
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: theme.contentWhite, NSAttributedString.Key.font: theme.onestFont(size: 16, weight: .semiBold)]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: theme.contentWhite, NSAttributedString.Key.font: theme.onestFont(size: 16, weight: .semiBold)]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        titleLabel.textColor = theme.contentWhite
        titleLabel.font = theme.onestFont(size: 18, weight: .bold)
        titleLabel.textAlignment = .center
        
        backgroundsLabel.textColor = theme.contentSecondary
        backgroundsLabel.font = theme.onestFont(size: 13, weight: .semiBold)
        
        patternsLabel.textColor = theme.contentSecondary
        patternsLabel.font = theme.onestFont(size: 13, weight: .semiBold)
        
        [grabberView,
         titleLabel,
         segmentedControl,
         backgroundsLabel,
         backgroundsScrollView,
         patternsLabel,
         patternsScrollView,
         applyButton].forEach { contentView.addSubview($0) }
        
        setupGestures()
        updateContentForSelectedSegment()
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        let contentWidthWithMargins = size.width - (padding * 2)
        
        var h = size.height
        var w = size.width
        var x = CGFloat.zero
        let contentHeight = h * presentationPercentage
        initialContentY = h - contentHeight
        var y = initialContentY
        self.contentView.frame = CGRect(x: x, y: y, width: w, height: contentHeight)
        
        x = (w - 40) / 2
        y = 8
        w = 40
        h = 5
        self.grabberView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding
        y = grabberView.maxY + padding
        w = contentWidthWithMargins
        h = titleLabel.textHeight(w)
        self.titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = titleLabel.maxY + 20
        h = 44
        self.segmentedControl.frame = CGRect(x: x, y: y, width: w, height: h)
        segmentedControl.borderRadius = 22
        segmentedControl.borderColor = .clear
        
        y = segmentedControl.maxY + 26
        h = 16
        self.backgroundsLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        let itemWidth: CGFloat = 78
        let itemHeight: CGFloat = 104
        let scrollViewHeight = itemHeight + 20
        x = 0
        y = backgroundsLabel.maxY + padding
        w = size.width
        h = scrollViewHeight
        self.backgroundsScrollView.frame = CGRect(x: x, y: y, width: w, height: h)
        layoutScrollViewItems(backgroundsScrollView, itemWidth: itemWidth, itemHeight: itemHeight, leftInset: 16)
        
        w = contentWidthWithMargins
        h = 16
        y = backgroundsScrollView.maxY + 26
        x = padding
        self.patternsLabel.frame = .init(x: x, y: y, width: w, height: h)
        
        x = 0
        y = patternsLabel.maxY + padding
        w = size.width
        h = scrollViewHeight
        self.patternsScrollView.frame = .init(x: x, y: y, width: w, height: h)
        layoutScrollViewItems(patternsScrollView, itemWidth: itemWidth, itemHeight: itemHeight, leftInset: 16)
        
        x = padding
        w = contentWidthWithMargins
        h = 50
        y = patternsScrollView.maxY + 32
        self.applyButton.frame = .init(x: x, y: y, width: w, height: h)
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(_:)))
        addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        contentView.addGestureRecognizer(panGesture)
    }

    @objc private func handleBackgroundTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        if !contentView.frame.contains(location) {
            dismiss?()
        }
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                contentView.frame.origin.y = initialContentY + translation.y
            }
        case .ended:
            let velocity = gesture.velocity(in: self)
            let dismissThreshold: CGFloat = 100
            let dismissVelocity: CGFloat = 1000
            if translation.y > dismissThreshold || velocity.y > dismissVelocity {
                UIView.animate(withDuration: 0.25, animations: {
                    self.contentView.frame.origin.y = self.bounds.height
                }, completion: { [weak self] _ in
                    self?.dismiss?()
                })
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
                    self.contentView.frame.origin.y = self.initialContentY
                })
            }
        default:
            break
        }
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateContentForSelectedSegment()
    }

    private func updateContentForSelectedSegment() {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        backgroundsScrollView.subviews.forEach { $0.removeFromSuperview() }
        patternsScrollView.subviews.forEach { $0.removeFromSuperview() }
        if selectedIndex == 0 {
            populateScrollView(backgroundsScrollView, with: ["No Theme", "Name", "Name", "Name", "Name", "Name", "Name", "Name"])
            populateScrollView(patternsScrollView, with: ["No Theme", "Name", "Name", "Name", "Name", "Name", "Name", "Name"])
        } else {
            populateScrollView(backgroundsScrollView, with: ["Gallery", "Name", "Name", "Name", "Name", "Name", "Name", "Name"])
            populateScrollView(patternsScrollView, with: ["No Theme", "Name", "Name", "Name", "Name", "Name", "Name", "Name"])
        }
        updateSubviewsFrame(size)
    }

    private func populateScrollView(_ scrollView: UIScrollView, with items: [String]) {
        let itemWidth: CGFloat = 78
        let itemHeight: CGFloat = 104
        for title in items {
            let itemView = createThemeItemView(title: title, width: itemWidth, height: itemHeight)
            scrollView.addSubview(itemView)
        }
    }

    private func createThemeItemView(title: String, width: CGFloat, height: CGFloat) -> UIView {
        let theme = theme ?? Theme()
        
        let titleColor = theme.contentPrimary

        let isNoThemeCell = (title == "No Theme")
        let isGalleryCell = (title == "Gallery")
        
        let topBackgroundColor: UIColor
        let bottomBackgroundColor: UIColor

        if isNoThemeCell {
            topBackgroundColor = theme.bgWhiteTransparent10
            bottomBackgroundColor = theme.bgWhiteTransparent10
        }
        else if isGalleryCell {
            topBackgroundColor = .clear
            bottomBackgroundColor = theme.bgWhiteTransparent10
        } else {
            topBackgroundColor = theme.bgBlackTransparent20
            bottomBackgroundColor = theme.bgBlackTransparent20
        }

        let container = UIView()
        container.backgroundColor = bottomBackgroundColor
        container.borderRadius = 16

        let previewHeight: CGFloat = 68.0
        let previewView = UIView()
        previewView.frame = CGRect(x: 0, y: 0, width: width, height: previewHeight)
        previewView.backgroundColor = topBackgroundColor
        container.addSubview(previewView)

        if isNoThemeCell {
            let imageView = UIImageView(image: theme.crossIcon?.withTintColor(theme.contentSecondary))

            imageView.contentMode = .center
            imageView.frame = previewView.bounds
            previewView.addSubview(imageView)
        } else if title == "Gallery" {
            let galleryImageView = createGalleryImageView(in: previewView.bounds)
            previewView.addSubview(galleryImageView)
        }

        let label = UILabel()
        label.text = title
        label.textColor = titleColor
        label.font = theme.onestFont(size: 13, weight: .semiBold)
        label.textAlignment = .center
        let bottomAreaY = previewHeight
        let bottomAreaHeight = height - previewHeight
        label.frame = CGRect(x: 0, y: bottomAreaY, width: width, height: bottomAreaHeight)
        container.addSubview(label)

        return container
    }

    private func createGalleryImageView(in bounds: CGRect) -> UIView {
        let imageView = UIView(frame: bounds)
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(hex: "#FDBA74").cgColor, UIColor(hex: "#F97316").cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        imageView.layer.addSublayer(gradient)
        return imageView
    }

    private func layoutScrollViewItems(_ scrollView: UIScrollView, itemWidth: CGFloat, itemHeight: CGFloat, leftInset: CGFloat) {
        var xOffset: CGFloat = leftInset
        let itemSpacing: CGFloat = 15
        for itemView in scrollView.subviews {
            itemView.frame = CGRect(x: xOffset, y: 0, width: itemWidth, height: itemHeight)
            xOffset += itemWidth + itemSpacing
        }
        scrollView.contentSize = CGSize(width: xOffset - itemSpacing + leftInset, height: scrollView.bounds.height)
    }
}


final class SegmentedControl: UISegmentedControl {
    private var cornerRadius: CGFloat

    init(items: [Any]?, cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        super.init(items: items)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius

        guard selectedSegmentIndex >= 0,
            let selectedSegment = subviews[numberOfSegments] as? UIImageView else {
            return
        }

        selectedSegment.image = nil
        selectedSegment.backgroundColor = selectedSegmentTintColor
        selectedSegment.layer.removeAnimation(forKey: "SelectionBounds")
        selectedSegment.layer.cornerRadius = cornerRadius - layer.borderWidth
        selectedSegment.bounds = CGRect(origin: .zero, size: CGSize(
            width: selectedSegment.bounds.width,
            height: bounds.height - layer.borderWidth * 2
        ))
    }
}
