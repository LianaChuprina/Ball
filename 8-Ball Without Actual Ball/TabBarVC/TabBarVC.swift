import UIKit

 final class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
}

extension TabBarVC {
    func setupTabBar() {
        viewControllers = [instantiateMostMainVC(), instantiateMostSettingsVC()]
        
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .systemOrange
        tabBar.tintColor = .systemRed
        navigationController?.isNavigationBarHidden = true
    }
    
    func instantiateMostMainVC() -> UINavigationController {
        let viewController = MainVC(presenter: MainPresenter(model: MainModel())) ?? UIViewController()
        let navigationVC = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "mainImage"),
            selectedImage: UIImage(named: "mainImage")
        )
        
        return navigationVC
    }
    
    func instantiateMostSettingsVC() -> UINavigationController {
        let viewController = SettingsVC(presenter: SettingsPresenter(model: SettingsModel())) ?? UIViewController()
        let navigationVC = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "settingsImage"),
            selectedImage: UIImage(named: "settingsImage")
        )
        
        return navigationVC
    }
}
