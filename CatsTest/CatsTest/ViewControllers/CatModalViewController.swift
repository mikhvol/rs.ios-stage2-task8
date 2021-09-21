import UIKit

final class CatModalViewController: UIViewController {
    
    private var cat: CatModel?
    
    var delegate: CatDelegate?
    
    private var descriptionTextView: UITextView! {
        didSet {
            self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
            self.descriptionTextView.isEditable = false
            self.descriptionTextView.text = "defaultDescription"
            self.descriptionTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        }
    }
    
    private var breedLabel: UILabel! {
        didSet {
            self.breedLabel.translatesAutoresizingMaskIntoConstraints = false
            self.breedLabel.textAlignment = .center
            self.breedLabel.adjustsFontSizeToFitWidth = true
            self.breedLabel.text = "defaultBreed"
            self.breedLabel.font = UIFont(name: "Papyrus", size: 40)
        }
    }
    
    private var countryLabel: UILabel! {
        didSet {
            self.countryLabel.translatesAutoresizingMaskIntoConstraints = false
            self.countryLabel.textAlignment = .center
            self.countryLabel.adjustsFontSizeToFitWidth = true
            self.countryLabel.text = "defaultCountry"
            self.countryLabel.font = UIFont(name: "Papyrus-Condensed", size: 21)
        }
    }
    
    private var favoriteButton: UIButton! {
        didSet {
            self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
            self.favoriteButton.addTarget(self, action: #selector(self.favoriteButtonTapped), for: .touchUpInside)
            self.favoriteButton.setTitleColor(.systemBlue, for: .normal)
            self.favoriteButton.titleLabel?.font = UIFont(name: "Papyrus", size: 40)
            self.favoriteButton.titleLabel?.adjustsFontSizeToFitWidth = true
            self.updateTitleForButton()
        }
    }
    
    private var scrollView: UIScrollView! {
        didSet {
            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private var catImageView: UIImageView! {
        didSet {
            self.catImageView.image = UIImage(named: "cat.jpg")
            self.catImageView.translatesAutoresizingMaskIntoConstraints = false
            self.catImageView.isUserInteractionEnabled = true
            self.catImageView.contentMode = .scaleAspectFill
            self.catImageView.layer.cornerRadius = 10
            self.catImageView.clipsToBounds = true
        }
    }
    
    //MARK:- Initializing
    init(with cat: CatModel) {
        self.cat = cat
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- LifeCycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupViews()
        self.setupConstraints()
        self.updateUIdata()
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollView.resizeContentSize()
    }
    
    //MARK:- Setup Views & Constraints
    private func setupViews() {
        self.descriptionTextView = UITextView()
        self.catImageView = UIImageView()
        self.breedLabel = UILabel()
        self.countryLabel = UILabel()
        self.scrollView = UIScrollView()
        self.favoriteButton = UIButton()
        
        self.catImageView.addSubview(self.favoriteButton)
        self.scrollView.addSubview(self.catImageView)
        self.scrollView.addSubview(self.descriptionTextView)
        self.scrollView.addSubview(self.breedLabel)
        self.scrollView.addSubview(self.countryLabel)
        self.view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        let sizeWidth = self.view.frame.width - 40
        let sizeHeight = self.view.frame.height * 0.5
        let sizeButton = sizeHeight * 1/6
        NSLayoutConstraint.activate([self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                                     self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
                                     self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                     self.catImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     self.catImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
                                     self.catImageView.widthAnchor.constraint(equalToConstant: sizeWidth),
                                     self.catImageView.heightAnchor.constraint(equalToConstant: sizeHeight),
                                     self.favoriteButton.trailingAnchor.constraint(equalTo: self.catImageView.trailingAnchor, constant: -20),
                                     self.favoriteButton.bottomAnchor.constraint(equalTo: self.catImageView.bottomAnchor, constant: -20),
                                     self.favoriteButton.heightAnchor.constraint(equalToConstant: sizeButton),
                                     self.favoriteButton.widthAnchor.constraint(equalToConstant: sizeButton),
                                     self.breedLabel.topAnchor.constraint(equalTo: self.catImageView.bottomAnchor, constant: 30),
                                     self.breedLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40),
                                     self.breedLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.breedLabel.heightAnchor.constraint(equalToConstant: 45),
                                     self.countryLabel.topAnchor.constraint(equalTo: self.breedLabel.bottomAnchor, constant: 2),
                                     self.countryLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40),
                                     self.countryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.countryLabel.heightAnchor.constraint(equalToConstant: 30),
                                     self.descriptionTextView.topAnchor.constraint(equalTo: self.countryLabel.bottomAnchor, constant: 20),
                                     self.descriptionTextView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40),
                                     self.descriptionTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.descriptionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
    }
    
    //MARK:- Update UI
    private func updateUIdata() {
        self.catImageView.image = self.cat?.image
        self.breedLabel.text = self.cat?.name
        self.countryLabel.text = self.cat?.origin
        self.descriptionTextView.text = self.cat?.description
    }
    
    private func updateTitleForButton() {
        guard let cat = self.cat else { return }
        cat.isFavorite ? self.favoriteButton.setTitle("★", for: .normal) :
                         self.favoriteButton.setTitle("☆", for: .normal)
        self.favoriteButton.animate()
    }
    
    //MARK:- Actions
    @objc private func favoriteButtonTapped() {
        guard let cat = self.cat else { return }
        cat.isFavorite.toggle()
        self.updateTitleForButton()
        self.delegate?.changeStateFavoriteLabel()
    }
}
