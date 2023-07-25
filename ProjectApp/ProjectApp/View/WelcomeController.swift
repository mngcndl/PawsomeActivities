import Foundation
import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Pawsome Activities !"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let imageView1 = UIImageView()
            imageView1.image = UIImage(named: "sitting_dog")
            imageView1.contentMode = .scaleAspectFit
            imageView1.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView1)
        let smilly_dog = UIImageView()
        smilly_dog.image = UIImage(named: "smilly_dog")
        smilly_dog.contentMode = .scaleAspectFit
        smilly_dog.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(smilly_dog)
        let meme_dog = UIImageView()
        meme_dog.image = UIImage(named: "meme_dog")
        meme_dog.contentMode = .scaleAspectFit
        meme_dog.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(meme_dog)
        let dog_with_glasses = UIImageView()
        dog_with_glasses.image = UIImage(named: "dog_with_glasses")
        dog_with_glasses.contentMode = .scaleAspectFit
        dog_with_glasses.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(dog_with_glasses)

        let getStartedButton = UIButton(type: .system)
                getStartedButton.setTitle("Get Started", for: .normal)
                getStartedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
                getStartedButton.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
                getStartedButton.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(getStartedButton)

        NSLayoutConstraint.activate([
            imageView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            imageView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView1.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: imageView1.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            smilly_dog.topAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: 16),
            smilly_dog.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -16),
            smilly_dog.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            smilly_dog.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            meme_dog.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            meme_dog.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            meme_dog.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            meme_dog.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            dog_with_glasses.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            dog_with_glasses.topAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: 8),
            dog_with_glasses.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            dog_with_glasses.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    @objc private func getStartedButtonTapped() {
        let tabBarController = TabBarViewController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
            
    }
}
