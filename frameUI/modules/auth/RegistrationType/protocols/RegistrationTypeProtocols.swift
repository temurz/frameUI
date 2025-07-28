//
//  RegistrationTypeProtocols.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//
import UIKit

protocol RegistrationTypeViewToPresenterProtocol: AnyObject {
    var view: RegistrationTypeViewControllerProtocol? { get set }
    var interactor: RegistrationTypePresenterToInteractorProtocol? {get set}
    var router: RegistrationTypeRouterProtocol? {get set}
    
    func backAction(navigationController: UINavigationController?)
    func individualUserAction(navigationController: UINavigationController?)
    func businessUserAction(navigationController: UINavigationController?)
    func signIn(navigationController: UINavigationController?)
}

protocol RegistrationTypeViewControllerProtocol: AnyObject {
    
}

protocol RegistrationTypeRouterProtocol: AnyObject {
    static func createModule() -> RegistrationTypeViewController
    func popViewController(navigationController: UINavigationController?)
    func individualUserAction(navigationController: UINavigationController?)
    func businessUserAction(navigationController: UINavigationController?)
    func signIn(navigationController: UINavigationController?)
}

protocol RegistrationTypePresenterToInteractorProtocol: AnyObject {
    var presenter: RegistrationTypeInteractorToPresenterProtocol? {get set}
}

protocol RegistrationTypeInteractorToPresenterProtocol: AnyObject {
    
}
