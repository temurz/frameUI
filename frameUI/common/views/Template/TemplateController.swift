//
//  TemplateController.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import UIKit
public class TemplateController: UIViewController {
    private(set) var theme = Theme()
    private var topSafeArea: CGFloat!
    private var bottomSafeArea: CGFloat!
    
    public var topSafe: CGFloat? {
        get {
            return topSafeArea
        }
    }
    
    public var bottomSafe: CGFloat? {
        get {
            return bottomSafeArea
        }
    }
    
    public lazy var fullScreenPanGestureRecognizer: UIPanGestureRecognizer? = {
        let gestureRecognizer = UIPanGestureRecognizer()
        if let cachedInteractionController = self.navigationController?.value(forKey: "_cachedInteractionController") as? NSObject {
            let string = "handleNavigationTransition:"
            let selector = Selector(string)
            if cachedInteractionController.responds(to: selector) {
                gestureRecognizer.addTarget(cachedInteractionController, action: selector)
            }
        }
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        
        return gestureRecognizer
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(themeUpdated), name: NSNotification.Name("updateTheme"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(needFramesUpdate), name: NSNotification.Name("needFramesUpdate"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadContent()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topSafeArea = view.safeAreaInsets.top
        bottomSafeArea = view.safeAreaInsets.bottom
        updateFrames()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.backgroundColor
        if let gest = fullScreenPanGestureRecognizer {
            self.view.addGestureRecognizer(gest)
        }

        initialize()
    }
    
    @objc func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initialize() {}
    
    @objc private func needFramesUpdate() {
        updateFrames()
    }
    
    @objc private func themeUpdated() {
        theme = Theme()
        view.backgroundColor = theme.backgroundColor
        reloadContent()
    }
    
    public func removeLeftGesture() {
        if let f = fullScreenPanGestureRecognizer {
            view.removeGestureRecognizer(f)
        }
    }
    
    public func enablePopGesture(_ value: Bool) {
        fullScreenPanGestureRecognizer?.isEnabled = value
    }
    
    public func removeAllGestures() {
        removeLeftGesture()
    }
    
    public func customDismiss(animated: Bool = true, completion: @escaping () -> Void) {
        self.dismiss(animated: animated, completion: {
            completion()
        })
    }
    
    func updateFrames() {
        updateSubviewsFrames(view.bounds.size)
    }
    
    func updateSubviewsFrames(_ size: CGSize) {
        
    }
    
    func reloadContent() {}
    
    public func shouldReceivePan(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return checkIfAvailableBackGesture(windowView: self.view, parentView: self.view, touch: touch)
        
        //return touch.location(in: self.view).x < 100
    }
    
    public func shouldRequireFailureOfPan(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension TemplateController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer is UIPanGestureRecognizer {
            return false
        }
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return shouldReceivePan(gestureRecognizer, shouldReceive: touch)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return shouldRequireFailureOfPan(gestureRecognizer, shouldRequireFailureOf: otherGestureRecognizer)
    }
}
extension TemplateController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        enablePopGesture(self.navigationController?.viewControllers.count ?? 0 > 1)
    }
}

private func backGestureIsAllowed(in view: UIView, windowView: UIView, touch: UITouch) -> Bool {
    if view is UICollectionView {
        if ((view as? UICollectionView)?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection == .horizontal {
            return !view.bounds.contains(touch.location(in: view))
        }
    } else if view is UITableView {
        return touch.location(in: windowView).x < 100
    } else if (view as? UIScrollView)?.contentSize.width ?? 0 > view.bounds.width {
        return !view.bounds.contains(touch.location(in: view))
    }
    return true
}

private func checkIfAvailableBackGesture(windowView: UIView, parentView: UIView, touch: UITouch) -> Bool {
    let allViews = parentView.get(all: [UICollectionView.self, UITableView.self, UIScrollView.self])
    var value = true
    for view in allViews {
        value = backGestureIsAllowed(in: view, windowView: windowView, touch: touch)
        if !value {
            break
        }
    }
    return value
}

extension TemplateController {
    
}
