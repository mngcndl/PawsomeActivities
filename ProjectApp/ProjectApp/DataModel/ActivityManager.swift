import Foundation

protocol ActivityManagerProtocol {
    func fetchActivity(completion: @escaping (Result<ActivityResponseModel, Error>) -> Void)
}

class ActivityManager: ActivityManagerProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchActivity(completion: @escaping (Result<ActivityResponseModel, Error>) -> Void) {
        networkManager.fetchActivity { (result: Result<ActivityResponseModel, Error>) in
            switch result {
            case .success(let activity):
                completion(.success(activity))
                print("success case")
            case .failure(let error):
                completion(.failure(error))
                print("failure case")
            }
        }
    }
}
