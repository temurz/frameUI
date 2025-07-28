//
//  ShimmerLoader.swift
//  Tedr
//
//  Created by Kostya Lee on 29/06/25.
//

import Foundation
import UIKit
/// ShimmerLoader
///
/// A reusable shimmer (skeleton) loading animation for any UIView.
///
/// Features:
/// - Supports smooth gradient animation to indicate loading state.
/// - Can be applied to any UIView: labels, buttons, image views, etc.
/// - Easily start and stop the shimmer animation.
/// - Keeps shimmer logic isolated from view controllers and views.
///
/// Example usage:
/// ```swift
/// let shimmer = ShimmerLoader()
/// shimmer.startShimmer(on: myView)
///
/// // When loading is done
/// shimmer.stopShimmer()
/// ```
///
/// ShimmerLoader is recommended for loading placeholders, balances, avatars, or content skeletons.
final class ShimmerLoader {
    private var gradientLayer: CAGradientLayer?

    func startShimmer(on view: UIView) {
        stopShimmer() // На всякий случай удаляем старый shimmer

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = view.layer.cornerRadius

        let lightColor = UIColor.white.withAlphaComponent(0.3).cgColor
        let darkColor = UIColor.white.withAlphaComponent(0.1).cgColor

        gradientLayer.colors = [darkColor, lightColor, darkColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.0, 0.5, 1.0]

        view.layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.0, 0.25]
        animation.toValue = [0.75, 1.0, 1.0]
        animation.duration = 1.2
        animation.repeatCount = .infinity

        gradientLayer.add(animation, forKey: "shimmerAnimation")
    }

    func stopShimmer() {
        gradientLayer?.removeAllAnimations()
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
    }
}
