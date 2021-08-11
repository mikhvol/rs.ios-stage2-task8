//
//  CatsModalViewController.swift
//  CatsTest
//
//  Created by worker on 09.08.2021.
//

import UIKit

class CatsModalViewController: UIViewController, UIScrollViewDelegate {
    
    private var descriptionTextView: UITextView! {
        didSet {
            self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
            self.descriptionTextView.isEditable = false
            self.descriptionTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        }
    }
    
    private var breedLabel: UILabel! {
        didSet {
            self.breedLabel.translatesAutoresizingMaskIntoConstraints = false
            self.breedLabel.textAlignment = .center
            self.breedLabel.adjustsFontSizeToFitWidth = true
            self.breedLabel.font = UIFont(name: "Papyrus", size: 40)
        }
    }
    
    private var countryLabel: UILabel! {
        didSet {
            self.countryLabel.translatesAutoresizingMaskIntoConstraints = false
            self.countryLabel.textAlignment = .center
            self.countryLabel.adjustsFontSizeToFitWidth = true
            self.countryLabel.font = UIFont(name: "Papyrus-Condensed", size: 21)
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
            self.catImageView.contentMode = .scaleAspectFill
            self.catImageView.layer.cornerRadius = 10
            self.catImageView.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupViews()
        self.setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        self.scrollView.resizeContentSize()
    }
    
    private func setupViews() {
        self.descriptionTextView = UITextView()
        self.catImageView = UIImageView()
        self.breedLabel = UILabel()
        self.countryLabel = UILabel()
        self.scrollView = UIScrollView()
        
        self.scrollView.addSubview(self.catImageView)
        self.scrollView.addSubview(self.descriptionTextView)
        self.scrollView.addSubview(self.breedLabel)
        self.scrollView.addSubview(self.countryLabel)
        self.view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                                     self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
                                     self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                     self.catImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     self.catImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
                                     self.catImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40),
                                     self.catImageView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 2),
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
    
    func configureWith(cat: Cat) {
        guard let url = cat.image?.url else { return }
        NetworkService.shared.getCatImageFromCache(url: url) { (catImage) in
            DispatchQueue.main.async {
                self.catImageView.image = catImage
                self.descriptionTextView.text = cat.description
                self.breedLabel.text = cat.name
                self.countryLabel.text = cat.origin
            }
        }
    }
}
