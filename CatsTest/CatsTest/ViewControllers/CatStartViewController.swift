import UIKit

class CatStartViewController: UIViewController {
    
    private var portraitConstraints: [NSLayoutConstraint]!
    private var landscapeConstraints: [NSLayoutConstraint]!
    
    private var orLabel: UILabel! {
        didSet {
            self.orLabel.translatesAutoresizingMaskIntoConstraints = false
            self.orLabel.textAlignment = .center
            self.orLabel.text = "OR"
            self.orLabel.font = UIFont(name: "Papyrus", size: 17)
        }
    }
    
    private var catImageView: UIImageView! {
        didSet {
            self.catImageView.image = UIImage(named: "cat.jpg")
            self.catImageView.translatesAutoresizingMaskIntoConstraints = false
            self.catImageView.contentMode = .scaleAspectFill
            self.catImageView.layer.cornerRadius = 10
            self.catImageView.layer.backgroundColor = UIColor.clear.cgColor
            self.catImageView.layer.shadowColor = UIColor.gray.cgColor
            self.catImageView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
            self.catImageView.layer.shadowRadius = 3.0
            self.catImageView.layer.shadowOpacity = 0.3
            self.catImageView.clipsToBounds = true
        }
    }
    
    private var authInfoView: CatAuthInfoView! {
        didSet {
            self.authInfoView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private var greenButton: UIButton! {
        didSet {
            self.greenButton.translatesAutoresizingMaskIntoConstraints = false
            self.greenButton.addTarget(self, action: #selector(self.greenButtonTapped), for: .touchUpInside)
            self.greenButton.setBackgroundImage(UIImage(named: "green_button"), for: .normal)
            self.greenButton.setTitle("Taste it!", for: .normal)
            self.greenButton.setTitleColor(.black, for: .normal)
            self.greenButton.titleLabel?.font = UIFont(name: "Papyrus", size: 31)
            self.greenButton.layer.backgroundColor = UIColor.clear.cgColor
            self.greenButton.layer.shadowColor = UIColor.gray.cgColor
            self.greenButton.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
            self.greenButton.layer.shadowRadius = 3.0
            self.greenButton.layer.shadowOpacity = 0.6
        }
    }
    
    //MARK:- LifeCycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupViews()
        self.setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startAnimate()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if (size.height > size.width) {
            NSLayoutConstraint.deactivate(self.landscapeConstraints)
            NSLayoutConstraint.activate(self.portraitConstraints)
            } else if (size.height <= size.width) {
                NSLayoutConstraint.deactivate(self.portraitConstraints)
                NSLayoutConstraint.activate(self.landscapeConstraints)
            }
    }
    
    //MARK:- Setup Views & Constraints
    private func setupViews() {
        self.catImageView = UIImageView()
        self.authInfoView = CatAuthInfoView()
        self.orLabel = UILabel()
        self.greenButton = UIButton()
        
        self.view.addSubview(self.catImageView)
        self.view.addSubview(self.authInfoView)
        self.view.addSubview(self.greenButton)
        self.view.addSubview(self.orLabel)
    }
    
    private func setupConstraints() {
        self.portraitConstraints = [self.catImageView.widthAnchor.constraint(equalToConstant: 100),
                                    self.catImageView.heightAnchor.constraint(equalToConstant: 100),
                                    self.catImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 100),
                                    self.catImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -70),
                                    self.authInfoView.topAnchor.constraint(equalTo: self.catImageView.bottomAnchor,constant: -13),
                                    self.authInfoView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                                    self.authInfoView.heightAnchor.constraint(equalToConstant: 31),
                                    self.authInfoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                    self.orLabel.topAnchor.constraint(equalTo: self.authInfoView.bottomAnchor, constant: 30),
                                    self.orLabel.widthAnchor.constraint(equalToConstant: 50),
                                    self.orLabel.heightAnchor.constraint(equalToConstant: 50),
                                    self.orLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                    self.greenButton.topAnchor.constraint(equalTo: self.orLabel.bottomAnchor, constant: 70),
                                    self.greenButton.widthAnchor.constraint(equalToConstant: 150),
                                    self.greenButton.heightAnchor.constraint(equalToConstant: 150),
                                    self.greenButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)]
        
        self.landscapeConstraints = [self.catImageView.widthAnchor.constraint(equalToConstant: 100),
                                     self.catImageView.heightAnchor.constraint(equalToConstant: 100),
                                     self.catImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 100),
                                     self.catImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
                                     self.authInfoView.topAnchor.constraint(equalTo: self.catImageView.bottomAnchor,constant: -13),
                                     self.authInfoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                                     self.authInfoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
                                     self.authInfoView.heightAnchor.constraint(equalToConstant: 31),
                                     self.authInfoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.orLabel.topAnchor.constraint(equalTo: self.authInfoView.bottomAnchor, constant: 20),
                                     self.orLabel.widthAnchor.constraint(equalToConstant: 50),
                                     self.orLabel.heightAnchor.constraint(equalToConstant: 50),
                                     self.orLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.greenButton.topAnchor.constraint(equalTo: self.orLabel.bottomAnchor, constant: 20),
                                     self.greenButton.widthAnchor.constraint(equalToConstant: 150),
                                     self.greenButton.heightAnchor.constraint(equalToConstant: 150),
                                     self.greenButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)]
        
        let size = UIScreen.main.bounds.size
        if size.height > size.width {
            NSLayoutConstraint.activate(self.portraitConstraints)
        } else {
            NSLayoutConstraint.activate(self.landscapeConstraints)
        }
    }
    
    //MARK:- Animations
    private func startAnimate() {
        self.catImageView.animate()
    }
    
    //MARK:- Actions
    @objc private func greenButtonTapped() {
        let catsTabBarVC = CatTabBarController()
        catsTabBarVC.modalPresentationStyle = .fullScreen
        catsTabBarVC.modalTransitionStyle = .flipHorizontal
        self.present(catsTabBarVC, animated: true)
    }
}
