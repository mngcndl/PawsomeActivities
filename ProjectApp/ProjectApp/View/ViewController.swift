import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate, ActivityTableViewCellDelegate {
    
    let favoriteVC = FavoriteViewController()
    
    private let activityManager: ActivityManagerProtocol = ActivityManager(networkManager: NetworkManager())
    private var fetchedActivity: ActivityResponseModel?
    private var activities: [ActivityResponseModel] = []
    
    private let dogManager: DogManagerProtocol = DogManager(networkManager: NetworkManager())
    private var fetchedDog: DogResponseModel?
    private var dogs: [DogResponseModel] = []
    
    private let numberOfActivitiesToFetch: Int = 5

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = false
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfActivitiesToFetch
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: "activityCell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as? ActivityTableViewCell else {
            fatalError("Couldn't dequeue cell with identifier: activityCell")
        }
        if self.activities.count > 0 &&  self.dogs.count > 0 && self.activities.count == self.dogs.count {
            let activity = self.activities[indexPath.row]
            let dog = self.dogs[indexPath.row]
            cell.setUpData(activity)
            cell.setUpImage(dog)
            cell.activity = activity
            cell.dog = dog
            cell.delegate = favoriteVC
            cell.delegate = self
            cell.setUpViews()
            cell.backgroundColor = .systemBackground
        }
        return cell
    }
    
    func toFavoriteButtonTapped(activity: ActivityResponseModel, dog: DogResponseModel) {
        favoriteVC.toFavoriteButtonTapped(activity: activity, dog: dog)
        favoriteVC.favoriteTableView.reloadData()
    }
    
    private func fetchActivity() {
            let dispatchGroup = DispatchGroup()

            for _ in 1...numberOfActivitiesToFetch {
                dispatchGroup.enter()

                activityManager.fetchActivity { [weak self] result in
                    guard let self = self else { return }

                    switch result {
                    case .success(let activity):
                        DispatchQueue.main.async {
                            print("success in viewController fetchActivity")
                            print(activity)
                            self.activities.append(activity)
                            dispatchGroup.leave()
                        }

                    case .failure(let error):
                        print("Error fetching activities: \(error)")
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.reloadData()
            }
        }

    private func fetchDog() {
            let dispatchGroup = DispatchGroup()

            for _ in 1...numberOfActivitiesToFetch {
                dispatchGroup.enter()

                dogManager.fetchDog { [weak self] result in
                    guard let self = self else { return }

                    switch result {
                    case .success(let dog):
                        DispatchQueue.main.async {
                            print("success in viewController fetchActivity")
                            print(dog)
                            self.dogs.append(dog)
                            dispatchGroup.leave()
                        }

                    case .failure(let error):
                        print("Error fetching activities: \(error)")
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.reloadData()
            }
        }
    
    func reloadData() {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewController(activityManager: activityManager)
        detailViewController.delegate = self
        let activity = self.activities[indexPath.row]
        let dog = self.dogs[indexPath.row]
        detailViewController.data = activity
        detailViewController.imageData = dog
    
        present(detailViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Res"
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: "activityCell")
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil

        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .clear
        view.addSubview(tableView)

        fetchActivity()
        fetchDog()
    }
}

