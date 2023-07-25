import Foundation

protocol DogManagerProtocol {
    func fetchDog(completion: @escaping (Result<DogResponseModel, Error>) -> Void)
}

class DogManager: DogManagerProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchDog(completion: @escaping (Result<DogResponseModel, Error>) -> Void) {
        networkManager.fetchDog { (result: Result<DogResponseModel, Error>) in
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
