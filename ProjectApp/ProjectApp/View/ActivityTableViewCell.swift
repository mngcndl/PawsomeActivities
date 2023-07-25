import UIKit

protocol ActivityTableViewCellDelegate: AnyObject {
    func toFavoriteButtonTapped(activity: ActivityResponseModel, dog: DogResponseModel)
}


final class ActivityTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var delegate: ActivityTableViewCellDelegate?

    var dog: DogResponseModel? = nil
    var activity: ActivityResponseModel? = nil

    private let filledHeartImage = UIImage(named: "filledHeart")
    private func setToFilledHeartImage() {
        toFavoriteButton.setImage(filledHeartImage, for: .normal)
    }

    
    private lazy var activityName: UILabel = {
        let activityName = UILabel()
        activityName.numberOfLines = 0
        activityName.font = UIFont.systemFont(ofSize: 20)
        activityName.textAlignment = .center
        return activityName
    }()
    
    private lazy var dogImageView: UIImageView = {
        let dogImageView = UIImageView()
        dogImageView.contentMode = .scaleAspectFill
        dogImageView.clipsToBounds = true
        return dogImageView
    }()
    
    private lazy var toFavoriteButton: UIButton = {
        let toFavoriteButton = UIButton()
        toFavoriteButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
        return toFavoriteButton
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(_ data: ActivityResponseModel) {
        activityName.text = data.activity
    }

    func setUpImage(_ data: DogResponseModel) {
        guard let imageURL = URL(string: data.message) else {
            print("URL error")
            fatalError()
        }
        
        dogImageView.download(from: imageURL, mode: .scaleAspectFit)
        print("Image")
        print(data.message)
    }

    @objc func toFavoriteButtonTapped() {
        setToFilledHeartImage()
        self.delegate?.toFavoriteButtonTapped(activity: activity!, dog: dog!)
    }

    
    func setUpViews() {
        contentView.addSubview(activityName)
        contentView.addSubview(dogImageView)
        contentView.addSubview(toFavoriteButton)
        
        activityName.translatesAutoresizingMaskIntoConstraints = false
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        toFavoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            activityName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            activityName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            dogImageView.topAnchor.constraint(equalTo: activityName.bottomAnchor, constant: 8),
            dogImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dogImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            dogImageView.heightAnchor.constraint(equalTo: dogImageView.widthAnchor),
            
            toFavoriteButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            toFavoriteButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            toFavoriteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            toFavoriteButton.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 8),
            toFavoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
        ])
        toFavoriteButton.addTarget(self, action: #selector(toFavoriteButtonTapped), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityName.text = nil
        dogImageView.image = nil
    }
}
