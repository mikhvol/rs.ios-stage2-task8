import UIKit

class CatCell: UICollectionViewCell {
    
    static var identifier = "catCell"
    var representedIdentifier: String = ""
    
    var catImageView: UIImageView! {
        didSet {
            self.catImageView.image = UIImage(named: "cat.jpg")
            self.catImageView.translatesAutoresizingMaskIntoConstraints = false
            self.catImageView.contentMode = .scaleAspectFill
            self.catImageView.layer.cornerRadius = 10
            self.catImageView.clipsToBounds = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.catImageView = UIImageView()
        self.addSubview(self.catImageView)
    }
    
    func setupCell() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.7
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([self.catImageView.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.catImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     self.catImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     self.catImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.catImageView.image = UIImage(named: "cat.jpg")
    }
}
