import Foundation
import Moya

enum CommonAPITarget {
    case getActivity
    case getDog
}

extension CommonAPITarget: TargetType {
    var baseURL: URL {
        switch self {
        case .getActivity:
            return URL(string: "https://www.boredapi.com")!
        case .getDog:
            return URL(string: "https://dog.ceo/api/breeds")!
        }
    }

    var path: String {
        switch self {
        case .getActivity:
            return "/api/activity"
        case .getDog:
            return "/image/random"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json", "Cache-Control": "no-cache"]
    }
}

protocol NetworkManagerProtocol {
    func fetchActivity(completion: @escaping (Result<ActivityResponseModel, Error>) -> Void)
    func fetchDog(completion: @escaping (Result<DogResponseModel, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    private var provider = MoyaProvider<CommonAPITarget>()

    func fetchActivity(completion: @escaping (Result<ActivityResponseModel, Error>) -> Void) {
        request(target: .getActivity, completion: completion)
    }

    private var dogProvider = MoyaProvider<CommonAPITarget>()

    func fetchDog(completion: @escaping (Result<DogResponseModel, Error>) -> Void) {
        request(target: .getDog, completion: completion)
    }

    private func request<T: Decodable>(target: CommonAPITarget, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
