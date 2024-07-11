//
//  MainTabBarController.swift
//  Baby's diary
//
//  Created by mac on 09.07.2024.
//
import UIKit

class MainTabBarController: UITabBarController {
    weak var router: RouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let sleepViewController = SleepViewController()
        let statisticsViewController = StatisticsViewController()
        
        sleepViewController.tabBarItem = UITabBarItem(title: "Sleep", image: UIImage(systemName: "powersleep"), tag: 0)
        statisticsViewController.tabBarItem = UITabBarItem(title: "Statistics", image: UIImage(systemName: "chart.bar.fill"), tag: 1)
        
        let sleepNavController = UINavigationController(rootViewController: sleepViewController)
        let statisticsNavController = UINavigationController(rootViewController: statisticsViewController)
        
        viewControllers = [sleepNavController, statisticsNavController]
        tabBar.tintColor = .black
        
        sleepViewController.router = router
        statisticsViewController.router = router
    }
}
