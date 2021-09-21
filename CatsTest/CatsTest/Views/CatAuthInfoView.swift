import UIKit

final class CatAuthInfoView: UIView {
    
    private var apiKeyField: UITextField! {
        didSet {
            self.apiKeyField.translatesAutoresizingMaskIntoConstraints = false
            self.apiKeyField.backgroundColor = .white
            self.apiKeyField.placeholder = " ...please, enter your API key"
            self.apiKeyField.layer.borderColor = UIColor.systemGray.cgColor
            self.apiKeyField.layer.borderWidth = 1
            self.apiKeyField.layer.cornerRadius = 10
            self.apiKeyField.clipsToBounds = true
        }
    }
    
    //MARK:- Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup Views & Constraints
    private func setupViews() {
        self.apiKeyField = UITextField()
        self.apiKeyField.delegate = self
        self.addSubview(self.apiKeyField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([self.apiKeyField.heightAnchor.constraint(equalTo: self.heightAnchor),
                                     self.apiKeyField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
                                     self.apiKeyField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     self.apiKeyField.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        ])
    }
}

//MARK:- Delegates
extension CatAuthInfoView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.apiKeyField.resignFirstResponder()
        return true
    }
}
