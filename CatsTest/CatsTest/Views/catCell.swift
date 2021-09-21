import UIKit

final class CatCell: UICollectionViewCell {
    
    static var identifier = "catCell"
    private var representedIdentifier: String = ""
    
    var cat: CatModel! {
        didSet {
            self.catFavoriteLabel.isHidden = !self.cat.isFavorite
        }
    }
    
    private var catImageView: UIImageView! {
        didSet {
            self.catImageView.image = UIImage(named: "cat.jpg")
            self.catImageView.translatesAutoresizingMaskIntoConstraints = false
            self.catImageView.contentMode = .scaleAspectFill
            self.catImageView.layer.cornerRadius = 10
            self.catImageView.clipsToBounds = true
        }
    }
    
    private var catFavoriteLabel: UILabel! {
        didSet {
            self.catFavoriteLabel.translatesAutoresizingMaskIntoConstraints = false
            self.catFavoriteLabel.textColor = .systemBlue
            self.catFavoriteLabel.text = "★"
            self.catFavoriteLabel.font = UIFont(name: "Papyrus", size: 40)
            self.catFavoriteLabel.adjustsFontSizeToFitWidth = true
            self.catFavoriteLabel.isHidden = true
        }
    }
    
    //MARK:- Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup Views, Cell & Constraints
    private func setupViews() {
        self.catImageView = UIImageView()
        self.catFavoriteLabel = UILabel()
        self.addSubview(self.catImageView)
        self.addSubview(self.catFavoriteLabel)
    }
    
    private func setupCell() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.7
    }
    
    private func setupConstraints() {
        let sizeHeight = self.frame.height * 0.5
        let sizeFavoriteLabel = sizeHeight * 1/3
        NSLayoutConstraint.activate([self.catImageView.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.catImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     self.catImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     self.catImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     self.catFavoriteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                                     self.catFavoriteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
                                     self.catFavoriteLabel.heightAnchor.constraint(equalToConstant: sizeFavoriteLabel),
                                     self.catFavoriteLabel.widthAnchor.constraint(equalToConstant: sizeFavoriteLabel)
        ])
    }
    
    func configure(with cat: CatModel) {
        self.cat = cat
        self.getImage(for: self.cat)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.catImageView.image = UIImage(named: "cat.jpg")
    }
    
    private func getImage(for cat: CatModel) {
        guard let url = cat.JSONimage.url else { return }
        guard let imageUrl = URL(string: url) else { return }
        self.representedIdentifier = imageUrl.absoluteString
        
        CatNetworkService.shared.downloadImageWithCache(url: imageUrl.absoluteString) { (image) in
            DispatchQueue.main.async {
                if(self.representedIdentifier == imageUrl.absoluteString) {
                    self.cat.image = image
                    self.catImageView.image = nil
                    self.catImageView.alpha = 0
                    UIView.animate(withDuration: 0.65) {
                        self.catImageView.alpha = 1
                        self.catImageView.image = self.cat.image
                    }
                }
            }
        }
    }
}
