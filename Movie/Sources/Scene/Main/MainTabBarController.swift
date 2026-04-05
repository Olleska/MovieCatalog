//
//  MainTabBarController.swift
//  Movie
//
//  Created by Олеся Лыжина on 19.01.2026.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }
    
    private func setupTabs() {
        let mainVC = MainViewController()
        let collectionsVC = CollectionsViewController()
        let profileVC = ProfileViewController()
        
        let navMainController = UINavigationController(rootViewController: mainVC)
        let navCollectionsController = UINavigationController(rootViewController: collectionsVC)
        let navProfileController = UINavigationController(rootViewController: profileVC)
        
        mainVC.tabBarItem = UITabBarItem(title: "Главное", image: UIImage(named: "TV"), tag: 0)
        collectionsVC.tabBarItem = UITabBarItem(title: "Коллекции", image: UIImage(named: "Collections"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "Profile"), tag: 2)
        
        viewControllers = [navMainController, navCollectionsController, navProfileController]
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named:"tabBarColor")
        
        let selectedColor = UIColor(named: "textColor")
        let unselectedColor = UIColor(named: "colorBorderField")
        let tabBarFont = UIFont(name: "IBMPlexSans-Medium", size: 14)
        
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor!, .font: tabBarFont!]
        
        appearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedColor!, .font: tabBarFont!]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = selectedColor
        tabBar.unselectedItemTintColor = unselectedColor
    }
}
