import UIKit

final class CatTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarController()
    }
    
    //MARK:- Setup TabBarViewController
    private func setupTabBarController() {
        let catVC = CatViewController()
        catVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "cat_selected"), tag: 1)
        let favoritesVC = CatFavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favorites"), tag: 2)
        self.viewControllers = [catVC, favoritesVC]
        self.selectedIndex = 0
    }
    
}
