//
//  ReusableBottomSheetController.swift
//  Tedr
//
//  Created by Temur on 24/05/2025.
//


import UIKit

class ReusableBottomSheetController: TemplateController {

    private let sheetView: BottomSheetContentView

    init(sheetView: BottomSheetContentView) {
        self.sheetView = sheetView
        super.init()
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialize() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(sheetView)

        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissSheet))
        tapToDismiss.delegate = self
        view.addGestureRecognizer(tapToDismiss)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        let height = sheetView.preferredContentHeight()
        sheetView.frame = CGRect(x: 0, y: size.height, width: size.width, height: height)
        self.sheetView.frame.origin.y = size.height - height
    }

    @objc private func dismissSheet() {
        UIView.animate(withDuration: 0.25, animations: {
            self.sheetView.frame.origin.y = self.view.bounds.height
        }, completion: { _ in
            self.dismiss(animated: false)
        })
    }
}

extension ReusableBottomSheetController {
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location = touch.location(in: view)
        return !sheetView.frame.contains(location)
    }
}
