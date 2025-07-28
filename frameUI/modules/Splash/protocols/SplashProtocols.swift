//
//  SplashProtocols.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//
import Foundation
import UIKit
protocol ViewToPresenterSplashProtocol: AnyObject {
    var view: PresenterToViewSplashProtocol? {get set}
    var interactor: PresenterToInteractorSplashProtocol? {get set}
    var router: PresenterToRouterSplashProtocol? {get set}
    func getScreens()
    func signIn(navigationController: UINavigationController?)
    func pushToMain(navigationController: UINavigationController?)
}

protocol PresenterToViewSplashProtocol: AnyObject {
    func show(values: [SplashEntity])
}

protocol PresenterToRouterSplashProtocol: AnyObject {
    static func createModule() -> SplashController
    func pushToSignIn(navigationController: UINavigationController?)
    func pushToMain(navigationController: UINavigationController?)
}

protocol PresenterToInteractorSplashProtocol: AnyObject {
    var presenter: InteractorToPresenterSplashProtocol? {get set}
    func getScreens()
}

protocol InteractorToPresenterSplashProtocol: AnyObject {
    func show(values: [SplashEntity])
}
