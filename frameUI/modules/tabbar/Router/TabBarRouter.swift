//
//  TabBarRouter.swift
//  Tedr
//
//  Created by Temur on 17/05/2025.
//

struct TabBarRouter {
    static func createModule() -> MainTabBarController {
        let controllers = [
            WalletHomeRouter.createModule(),
            FavoritesVC(),
            ChatListRouter.createModule()
        ]
        let tabBarVC = MainTabBarController(
            viewControllers: controllers,
            tabItems: [
                FloatingTabBarItem(icon: Theme().walletIcon),
                FloatingTabBarItem(icon: Theme().servicesIcon),
                FloatingTabBarItem(icon: Theme().chatIcon)
            ]
        )
        return tabBarVC
    }
}
