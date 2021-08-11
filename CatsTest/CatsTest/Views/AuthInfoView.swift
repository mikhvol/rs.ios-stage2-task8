import UIKit

class AuthInfoView: UIView {
    
    var apiKeyField: UITextField! {
        didSet {
            self.apiKeyField.translatesAutoresizingMaskIntoConstraints = false
            self.apiKeyField.backgroundColor = .white
            self.apiKeyField.placeholder = " ...please, enter your API key"
            self.apiKeyField.layer.borderColor = UIColor.systemGray.cgColor
            self.apiKeyField.layer.borderWidth = 0.5
            self.apiKeyField.layer.cornerRadius = 5
            self.apiKeyField.clipsToBounds = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setupViews()
        self.setupConstraints()
        self.startAnimate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.apiKeyField = UITextField()
        self.addSubview(self.apiKeyField)
    }
    
    func startAnimate() {
        self.alpha = 0
        UIView.animate(withDuration: 1.0) {
            self.alpha = 1.0
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([self.apiKeyField.heightAnchor.constraint(equalToConstant: 31),
                                     self.apiKeyField.widthAnchor.constraint(equalToConstant: 300),
                                     self.apiKeyField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     self.apiKeyField.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
    }
}
