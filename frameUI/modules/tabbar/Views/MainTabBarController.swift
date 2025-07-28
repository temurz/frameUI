//
//  MainTabBarController.swift
//  Tedr
//
//  Created by Temur on 17/05/2025.
//


import UIKit

class MainTabBarController: TemplateController {

    private let container = UIView()
    private let tabBarView: FloatingTabBarView

    private var current: UIViewController?

    private let viewControllers: [UIViewController]

    init(viewControllers: [UIViewController], tabItems: [FloatingTabBarItem]) {
        self.viewControllers = viewControllers
        self.tabBarView = FloatingTabBarView(items: tabItems)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialize() {
        tabBarView.delegate = self
        
        view.backgroundColor = .black
        view.addSubview(container)
        view.addSubview(tabBarView)

        switchTo(index: 0)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        let margin = CGFloat(16)
        
        var x = CGFloat.zero
        var y = CGFloat.zero
        var w = size.width
        var h = size.height
        container.frame = .init(x: x, y: y, width: w, height: h)
        
        w = tabBarView.getWidth()
        x = size.width/2 - w/2
        h = 72
        y = size.height - (bottomSafe ?? 0) - margin - h
        tabBarView.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    private func switchTo(index: Int) {
        let newVC = viewControllers[index]
        guard current !== newVC else { return }

        
        let direction: CGFloat
        
        if let current = current, let currentIndex = viewControllers.firstIndex(of: current) {
            direction = index > currentIndex ? 1 : -1
        } else {
            direction = 1
        }
        current?.willMove(toParent: nil)
        addChild(newVC)

        let width = container.bounds.width
        newVC.view.frame = container.bounds.offsetBy(dx: direction * width, dy: 0)
        container.addSubview(newVC.view)

        UIView.animate(withDuration: 0.3, animations: {
            self.current?.view.frame = self.container.bounds.offsetBy(dx: -direction * width, dy: 0)
            newVC.view.frame = self.container.bounds
        }, completion: { _ in
            self.current?.view.removeFromSuperview()
            self.current?.removeFromParent()
            newVC.didMove(toParent: self)
            self.current = newVC
        })
    }
}

extension MainTabBarController: FloatingTabBarDelegate {
    func didSelectTab(index: Int) {
        switchTo(index: index)
    }
}
