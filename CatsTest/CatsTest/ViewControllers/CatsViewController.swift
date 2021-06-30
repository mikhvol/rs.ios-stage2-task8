import UIKit

class CatsViewController: UIViewController {
    
    var catsCollectionView: UICollectionView!
    var cats = [Cat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupConstraints()
        self.getCatBreeds()
        self.catsCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 80)
        self.catsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.catsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.catsCollectionView.backgroundColor = .white
        self.catsCollectionView.delegate = self
        self.catsCollectionView.dataSource = self
        self.catsCollectionView.register(catCell.self, forCellWithReuseIdentifier: catCell.identifier)
        self.view.addSubview(self.catsCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([self.catsCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                                     self.catsCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                                     self.catsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.catsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor)])
    }
    
    //MARK:- Fetching data
    
    func getCatBreeds() {
        NetworkService.shared.getCatBreeds {(cats) in
            self.cats = cats
            DispatchQueue.main.async {
                self.catsCollectionView.reloadData()
            }
        }
    }
}

extension CatsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = catCell.identifier
        let cell = self.catsCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! catCell
        let imageUrl = self.cats[indexPath.row].imageUrl ?? "no url"
        
        NetworkService.shared.downloadImageWithCache(url: imageUrl) {(image) in
            cell.catImageView?.image = nil
            cell.catImageView?.image = image
            cell.layoutSubviews()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edgeSize = (self.catsCollectionView.frame.size.width - 40) / 3
        return CGSize(width: edgeSize, height: edgeSize)
    }
}
