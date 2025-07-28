//
//  PinCodeProtocols.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit

protocol ViewToPresenterPinCodeProtocol: AnyObject {
    var view: PresenterToViewPinCodeProtocol? { get set }
    var router: PresenterToRouterPinCodeProtocol? { get set }
    func submitPin(_ pin: String)
    func goBack(navigationController: UINavigationController?)
}

protocol PresenterToViewPinCodeProtocol: AnyObject {}

protocol PresenterToRouterPinCodeProtocol: AnyObject {
    static func createModule() -> PinCodeController
    func popToPrevious(navigationController: UINavigationController?)
}

protocol PresenterToInteractorPinCodeProtocol: AnyObject {
    var presenter: InteractorToPresenterPinCodeProtocol? { get set }
    func validatePin(_ pin: String)
}

protocol InteractorToPresenterPinCodeProtocol: AnyObject {
    func didValidatePin(success: Bool)
}
