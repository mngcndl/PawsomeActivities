import UIKit

protocol DetailViewControllerDelegate: AnyObject {
}


final class DetailViewController: UIViewController {
    
    private let activityManager: ActivityManagerProtocol

    init(activityManager: ActivityManagerProtocol) {
        self.activityManager = activityManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var data: ActivityResponseModel? {
        didSet {
            guard let data = data else { return }
            setUpData(data)
        }
    }
    
    var imageData: DogResponseModel? {
        didSet {
            guard let imageData = imageData else { return }
            setUpImageDetail(imageData)
        }
    }
    
    weak var delegate: DetailViewControllerDelegate?
    
    private lazy var activityLabel: UILabel = {
        let activityLabel = UILabel()
        activityLabel.translatesAutoresizingMaskIntoConstraints = false
        activityLabel.textAlignment = .center
        activityLabel.font = UIFont.systemFont(ofSize: 24)
        activityLabel.numberOfLines = 0
        return activityLabel
    }()   
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var typeHint: UILabel = {
        let typeHint = UILabel()
        typeHint.translatesAutoresizingMaskIntoConstraints = false
        typeHint.text = "Type of activity:"
        typeHint.textColor = .systemGray
        typeHint.font = UIFont.systemFont(ofSize: 20)
        typeHint.textAlignment = .left
        typeHint.numberOfLines = 0
        return typeHint
    }()
    
    private lazy var participantsHint: UILabel = {
        let participantsHint = UILabel()
        participantsHint.numberOfLines = 0
        participantsHint.font = UIFont.systemFont(ofSize: 20)
        participantsHint.translatesAutoresizingMaskIntoConstraints = false
        participantsHint.text = "Participants:"
        participantsHint.textColor = .systemGray
        return participantsHint
    }()
    
    private lazy var participantsLabel: UILabel = {
        let participantsLabel = UILabel()
        participantsLabel.translatesAutoresizingMaskIntoConstraints = false
        participantsLabel.font = UIFont.systemFont(ofSize: 20)
        participantsLabel.textAlignment = .left
        return participantsLabel
    }()
    
    private lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.systemFont(ofSize: 20)
        typeLabel.textAlignment = .left
        typeLabel.numberOfLines = 0
        return typeLabel
    }()
    
    private func setUpViews(){
        view.backgroundColor = .systemBackground
        view.addSubview(activityLabel)
        view.addSubview(imageView)
        
        view.addSubview(typeHint)
        view.addSubview(participantsHint)
        
        view.addSubview(typeLabel)
        view.addSubview(participantsLabel)
        
        NSLayoutConstraint.activate([
            activityLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            activityLabel.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            activityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
         
            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45),
            imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 8),
            
            typeHint.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            typeHint.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
            typeHint.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            typeHint.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),

            participantsHint.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            participantsHint.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
            participantsHint.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            participantsHint.topAnchor.constraint(equalTo: typeHint.bottomAnchor, constant: 16),
            
            typeLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            typeLabel.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
            typeLabel.leadingAnchor.constraint(equalTo: typeHint.trailingAnchor, constant: 16),
            typeLabel.topAnchor.constraint(equalTo: typeHint.topAnchor),

            participantsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            participantsLabel.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
            participantsLabel.leadingAnchor.constraint(equalTo: participantsHint.trailingAnchor, constant: 16),
            participantsLabel.topAnchor.constraint(equalTo: participantsHint.topAnchor)
        ])
    }
    
    private func setUpData(_ data: ActivityResponseModel) {
        activityLabel.text = data.activity
        typeLabel.text = data.type
        participantsLabel.text = String(data.participants)
    }
    
    func setUpImageDetail(_ data: DogResponseModel) {
        guard let imageURL = URL(string: data.message) else {
            print("URL error")
            fatalError()
        }
        imageView.download(from: imageURL, mode: .scaleAspectFit)
        print("IMAGE IS SET")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
}
