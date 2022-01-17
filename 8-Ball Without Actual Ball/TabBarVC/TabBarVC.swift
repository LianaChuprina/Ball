import UIKit

class TabBarVC: UIViewController, UITabBarControllerDelegate {
    
    private var embedTabBarVC: UITabBarController = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        _SetupTabBar()
    }
}

extension TabBarVC {

    func _SetupTabBar() {
        embedTabBarVC.viewControllers = [instantiateMostMainVC(), instantiateMostSettingsVC()]
        
        embedTabBarVC.tabBar.barTintColor = .white
        embedTabBarVC.tabBar.unselectedItemTintColor = .black
        embedTabBarVC.tabBar.tintColor = .brown
        self.navigationController?.isNavigationBarHidden = true
        addChildViewControllerToView(embedTabBarVC,
                                     toContainer: view)
    }
    func instantiateMostMainVC() -> UINavigationController {
        let viewController = MainVC(presenter: MainPresenter(model: MainModel())) ?? UIViewController()
        let navigationVC = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem = UITabBarItem(
            title: "main",
            image: UIImage(named: "mainImage"),
            selectedImage: UIImage(named: "mainImage")
        )
        return navigationVC
    }
    func instantiateMostSettingsVC() -> UINavigationController {
        let viewController = SettingsVC(presenter: SettingsPresenter(model: SettingsModel())) ?? UIViewController()
        let navigationVC = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem = UITabBarItem(
            title: "settings",
            image: UIImage(named: "settingsImage"),
            selectedImage: UIImage(named: "settingsImage")
        )
        return navigationVC
    }

    }


extension UIViewController {
    func addChildViewControllerToView(_ child: UIViewController,
                                      toContainer container: UIView) {
        addChild(child)

        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        child.view.frame = container.bounds
        container.addSubview(child.view)

        child.didMove(toParent: self)
    }
}
