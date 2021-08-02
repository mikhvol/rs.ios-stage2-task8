import UIKit

class StartViewController: UIViewController {
    
    var catImageView: UIImageView! {
        didSet {
            self.catImageView.image = UIImage(named: "cat.jpg")
            self.catImageView.translatesAutoresizingMaskIntoConstraints = false
            self.catImageView.contentMode = .scaleAspectFill
            self.catImageView.layer.cornerRadius = 10
            self.catImageView.clipsToBounds = true
        }
    }
    
    var authInfoView: AuthInfoView! {
        didSet {
            self.authInfoView.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupViews()
        self.setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.startAnimate()
    }
    
    func setupViews() {
        self.catImageView = UIImageView()
        self.authInfoView = AuthInfoView()
        self.view.addSubview(self.catImageView)
        self.view.addSubview(self.authInfoView)
    }
    
    func setupConstraints() {
        let width = self.view.frame.width
        let height = self.view.frame.height / 4
        NSLayoutConstraint.activate([self.catImageView.widthAnchor.constraint(equalToConstant: 300),
                                     self.catImageView.heightAnchor.constraint(equalToConstant: 300),
                                     self.catImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.catImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     self.authInfoView.widthAnchor.constraint(equalToConstant: width),
                                     self.authInfoView.heightAnchor.constraint(equalToConstant: height),
                                     self.authInfoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.authInfoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150)])
    }
    
    func startAnimate() {
        UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.catImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
                self.catImageView.transform = CGAffineTransform(translationX: 0.0, y: -200.0)
            }, completion: nil)
        })
    }
}
