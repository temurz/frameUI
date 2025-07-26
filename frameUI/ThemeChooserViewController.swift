//
//  ThemeChooserViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 17/07/25.
//

import CoreFoundation
import UIKit

class ThemeChooserViewController: UIViewController {

    var presentationPercentage: CGFloat = 0.6
    private var contentView: UIView!
    private var initialContentY: CGFloat = 0

    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2.5
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose theme"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Theme", "Background"])
        control.selectedSegmentIndex = 0
        control.backgroundColor = UIColor(hex: "#2C2C54")
        control.selectedSegmentTintColor = UIColor(hex: "#8B5CF6")
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
        control.setTitleTextAttributes(normalTextAttributes, for: .normal)
        control.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        control.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return control
    }()

    private let backgroundsLabel: UILabel = {
        let label = UILabel()
        label.text = "CHAT BACKGROUNDS"
        label.textColor = UIColor(hex: "#A190CC")
        label.font = .systemFont(ofSize: 13, weight: .semibold)
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
        label.textColor = UIColor(hex: "#A190CC")
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()

    private let patternsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#FB94ED").cgColor, UIColor(hex: "#EF46D9").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
        updateContentForSelectedSegment()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutContentView()
    }

    private func setupUI() {
        contentView = UIView()
        contentView.backgroundColor = UIColor(hex: "#403378")
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.clipsToBounds = true
        view.addSubview(contentView)
        
        [grabberView,
         titleLabel,
         segmentedControl,
         backgroundsLabel,
         backgroundsScrollView,
         patternsLabel,
         patternsScrollView,
         applyButton].forEach { contentView.addSubview($0) }
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(_:)))
        view.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        contentView.addGestureRecognizer(panGesture)
    }

    private func layoutContentView() {
        let screenHeight = view.bounds.height
        let screenWidth = view.bounds.width
        let contentHeight = screenHeight * presentationPercentage
        initialContentY = screenHeight - contentHeight
        contentView.frame = CGRect(x: 0, y: initialContentY, width: screenWidth, height: contentHeight)
        layoutContentElements()
    }

    private func layoutContentElements() {
        let padding: CGFloat = 20
        let contentWidth = contentView.bounds.width
        grabberView.frame = CGRect(x: (contentWidth - 40) / 2, y: 8, width: 40, height: 5)
        titleLabel.frame = CGRect(x: padding, y: grabberView.frame.maxY + 15, width: contentWidth - (padding * 2), height: 24)
        segmentedControl.frame = CGRect(x: padding, y: titleLabel.frame.maxY + 20, width: contentWidth - (padding * 2), height: 44)
        segmentedControl.borderRadius = 22
        backgroundsLabel.frame = CGRect(x: padding, y: segmentedControl.frame.maxY + 30, width: contentWidth - (padding * 2), height: 16)
        let itemWidth: CGFloat = 78
        let itemHeight: CGFloat = 104
        let scrollViewHeight = itemHeight + 20
        backgroundsScrollView.frame = CGRect(x: 0, y: backgroundsLabel.frame.maxY + 15, width: contentWidth, height: scrollViewHeight)
        layoutScrollViewItems(backgroundsScrollView, itemWidth: itemWidth, itemHeight: itemHeight, leftInset: 16)
        patternsLabel.frame = CGRect(x: padding, y: backgroundsScrollView.frame.maxY + 30, width: contentWidth - (padding * 2), height: 16)
        patternsScrollView.frame = CGRect(x: 0, y: patternsLabel.frame.maxY + 15, width: contentWidth, height: scrollViewHeight)
        layoutScrollViewItems(patternsScrollView, itemWidth: itemWidth, itemHeight: itemHeight, leftInset: 16)
        let buttonHeight: CGFloat = 50
        let buttonY = patternsScrollView.frame.maxY + 32
        applyButton.frame = CGRect(x: padding, y: buttonY, width: contentWidth - (padding * 2), height: buttonHeight)
        if let gradientLayer = applyButton.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = applyButton.bounds
        }
    }

    @objc private func handleBackgroundTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        if !contentView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                contentView.frame.origin.y = initialContentY + translation.y
            }
        case .ended:
            let velocity = gesture.velocity(in: view)
            let dismissThreshold: CGFloat = 100
            let dismissVelocity: CGFloat = 1000
            if translation.y > dismissThreshold || velocity.y > dismissVelocity {
                UIView.animate(withDuration: 0.25, animations: {
                    self.contentView.frame.origin.y = self.view.bounds.height
                }, completion: { _ in
                    self.dismiss(animated: false)
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
        view.setNeedsLayout()
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
        
        let darkbg = UIColor(hex:"#29214d")
        let lightbg = UIColor(hex:"#332960")
        
        let lightPurple = UIColor(hex: "#645991")
        let darkPurple = UIColor(hex: "#534785")
        
        let titleColor = UIColor.white

        let isNoThemeCell = (title == "No Theme")
        let isGalleryCell = (title == "Gallery")
        
        let topBackgroundColor: UIColor
        let bottomBackgroundColor: UIColor

        if isNoThemeCell {
            topBackgroundColor = lightPurple
            bottomBackgroundColor = darkPurple
        }
        else if isGalleryCell {
            topBackgroundColor = UIColor.yellow
            bottomBackgroundColor = darkPurple
        } else {
            topBackgroundColor = darkbg
            bottomBackgroundColor = lightbg
        }

        let container = UIView()
        container.backgroundColor = bottomBackgroundColor
        container.layer.cornerRadius = 16
        container.clipsToBounds = true

        let previewHeight: CGFloat = 68.0
        let previewView = UIView()
        previewView.frame = CGRect(x: 0, y: 0, width: width, height: previewHeight)
        previewView.backgroundColor = topBackgroundColor
        container.addSubview(previewView)

        if isNoThemeCell {
            let imageView = UIImageView(image: UIImage(named: "cross"))
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
        label.font = .systemFont(ofSize: 13, weight: .semibold)
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
