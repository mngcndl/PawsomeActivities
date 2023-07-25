import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    private let allResultsVC = ViewController()
    private var favoriteVC: FavoriteViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteVC = allResultsVC.favoriteVC
        setupTabBar()
    }

    private func setupTabBar() {
        allResultsVC.title = "Res"
        allResultsVC.tabBarItem = UITabBarItem(title: "all", image: UIImage(named: "menu"), tag: 0)
        let allResultsNavController = UINavigationController(rootViewController: allResultsVC)

        if let favoriteVC = favoriteVC {
            favoriteVC.title = "Fav"
            favoriteVC.tabBarItem = UITabBarItem(title: "favorite", image: UIImage(named: "filledHeart"), tag: 0)
            let favoriteNavController = UINavigationController(rootViewController: favoriteVC)
            viewControllers = [allResultsNavController, favoriteNavController]
        }
        else {fatalError()}

        
    }
}
