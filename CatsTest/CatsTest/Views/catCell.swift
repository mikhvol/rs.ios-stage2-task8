import UIKit

class catCell: UICollectionViewCell {
    
    static var identifier = "catCell"
    
    var catImageView: UIImageView! {
        didSet {
            self.catImageView.translatesAutoresizingMaskIntoConstraints = false
            self.catImageView.contentMode = .scaleAspectFill
            self.catImageView.layer.cornerRadius = 10
            self.catImageView.clipsToBounds = true
            self.catImageView.image = UIImage(named: "cat.jpg")
        }
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        setupCell()
        setupViews()
        setupConstraints()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func setupViews() {
        self.catImageView = UIImageView()
        self.addSubview(self.catImageView)
    }
    
    func setupCell() {
        self.layer.cornerRadius = 10
                self.layer.borderWidth = 1.0
                self.layer.borderColor = UIColor.lightGray.cgColor

                self.layer.backgroundColor = UIColor.white.cgColor
                self.layer.shadowColor = UIColor.gray.cgColor
                self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
                self.layer.shadowRadius = 2.0
                self.layer.shadowOpacity = 1.0
                self.layer.masksToBounds = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([self.catImageView.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.catImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     self.catImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     self.catImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
