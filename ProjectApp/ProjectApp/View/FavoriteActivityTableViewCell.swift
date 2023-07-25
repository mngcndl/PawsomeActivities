import UIKit

final class FavoriteActivityTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private lazy var favActivityName: UILabel = {
        let favActivityName = UILabel()
        favActivityName.numberOfLines = 0
        favActivityName.textAlignment = .center
        favActivityName.font = UIFont.systemFont(ofSize: 20)
        favActivityName.backgroundColor = .white
        favActivityName.layer.cornerRadius = 30
        return favActivityName
    }()
    
    private lazy var favDogImageView: UIImageView = {
        let favDogImageView = UIImageView()
        favDogImageView.contentMode = .center // Set the content mode to center
        favDogImageView.clipsToBounds = true
        return favDogImageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(_ data: ActivityResponseModel) {
        favActivityName.text = data.activity
    }

    func setUpImage(_ data: DogResponseModel) {
        guard let imageURL = URL(string: data.message) else {
            print("URL error")
            fatalError()
        }
        
        favDogImageView.download(from: imageURL, mode: .scaleAspectFit)
        print("Image")
        print(data.message)
    }


    
    func setUpViews() {
        contentView.addSubview(favActivityName)
        contentView.addSubview(favDogImageView)
        
        favActivityName.translatesAutoresizingMaskIntoConstraints = false
        favDogImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favActivityName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favActivityName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            favActivityName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            favDogImageView.topAnchor.constraint(equalTo: favActivityName.bottomAnchor, constant: 8),
            favDogImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            favDogImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            favDogImageView.heightAnchor.constraint(equalTo: favDogImageView.widthAnchor),
            favDogImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favActivityName.text = nil
        favDogImageView.image = nil
    }
}
