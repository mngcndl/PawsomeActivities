import Foundation
import UIKit
import Foundation

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate, ActivityTableViewCellDelegate{
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         favoriteTableView.reloadData()
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteActivityCell", for: indexPath) as? FavoriteActivityTableViewCell else {
            fatalError("Couldn't dequeue cell with identifier: favoriteActivityCell")
        }
        
        print("favoriteActivities.count")
        print(favoriteActivities.count)
        if indexPath.row < favoriteActivities.count {
            let activity = favoriteActivities[indexPath.row]
            let dog = favoriteDogs[indexPath.row]
            cell.setUpData(activity)
            cell.setUpImage(dog)
            cell.setUpViews()
            cell.backgroundColor = .systemBackground
            let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
            let backgroundImage = UIImage(named: "backgroundImage")
            backgroundImageView.image = backgroundImage
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.clipsToBounds = true
            cell.backgroundView = UIView()
            cell.backgroundView!.addSubview(backgroundImageView)
            
            
        } else {
            cell.backgroundColor = .systemBackground
        }
        return cell
    }

    func toFavoriteButtonTapped(activity: ActivityResponseModel, dog: DogResponseModel) {
        self.favoriteActivities.append(activity)
        self.favoriteDogs.append(dog)
        saveFavoriteData()
        self.favoriteTableView.reloadData()
    }
    
    private func saveFavoriteData() {
        let defaults = UserDefaults.standard
        let favoriteActivitiesData = try? JSONEncoder().encode(favoriteActivities)
        let favoriteDogsData = try? JSONEncoder().encode(favoriteDogs)
        defaults.set(favoriteActivitiesData, forKey: "favoriteActivities")
        defaults.set(favoriteDogsData, forKey: "favoriteDogs")
        defaults.synchronize()
    }
    
    private var activityManager = ActivityManager(networkManager: NetworkManager())
    private var favoriteActivities: [ActivityResponseModel] = []
    private var favoriteDogs: [DogResponseModel] = []
    
    lazy var favoriteTableView: UITableView = {
        var favoriteTableView = UITableView()
        favoriteTableView.backgroundColor = .red
        return favoriteTableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = false
        favoriteTableView.reloadData()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoriteDogs.count > 0 {
            return favoriteDogs.count
        } else {
            return 1
        }
    }
    
    func reloadData() {
        favoriteTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewController(activityManager: activityManager)
        detailViewController.delegate = self
        let activity = self.favoriteActivities[indexPath.row]
        let dog = self.favoriteDogs[indexPath.row]
        detailViewController.data = activity
        detailViewController.imageData = dog

        present(detailViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Fav"
        favoriteTableView.register(FavoriteActivityTableViewCell.self, forCellReuseIdentifier: "favoriteActivityCell")
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.tableHeaderView = nil
        

        view.backgroundColor = .systemBackground
        favoriteTableView.backgroundColor = .clear
        view.addSubview(favoriteTableView)
        
        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        retrieveFavoriteData()
        favoriteTableView.reloadData()
    }
    
    private func retrieveFavoriteData() {
        let defaults = UserDefaults.standard
        if let favoriteActivitiesData = defaults.data(forKey: "favoriteActivities") {
            if let decodedActivities = try? JSONDecoder().decode([ActivityResponseModel].self, from: favoriteActivitiesData) {
                favoriteActivities = decodedActivities
            }
        }
        if let favoriteDogsData = defaults.data(forKey: "favoriteDogs") {
            if let decodedDogs = try? JSONDecoder().decode([DogResponseModel].self, from: favoriteDogsData) {
                favoriteDogs = decodedDogs
            }
        }
    }
}

