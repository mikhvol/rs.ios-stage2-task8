import UIKit

final class CatFavoritesViewController: UIViewController {
    
    private var cats = [CatModel]()
    
    private var catsCollectionView: UICollectionView!
    
    private var lastIndexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupConstraints()
        self.catsCollectionView.reloadData()
    }
    
    func getCats() {
        self.cats = CatDataManager.shared.cats.filter({ $0.isFavorite == true })
        
        DispatchQueue.main.async {
            self.catsCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getCats()
    }
    
    //MARK:- Setup CollectionView & Constraints
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        self.catsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.catsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.catsCollectionView.backgroundColor = .white
        self.catsCollectionView.delegate = self
        self.catsCollectionView.dataSource = self
        self.catsCollectionView.register(CatCell.self, forCellWithReuseIdentifier: CatCell.identifier)
        self.view.addSubview(self.catsCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([self.catsCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                                     self.catsCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                                     self.catsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.catsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor)])
    }
}

extension CatFavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CatCell.identifier
        let cell = self.catsCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CatCell
        let catModel = self.cats[indexPath.row]
        cell.configure(with: catModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellsInRow = 1
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let catModel = self.cats[indexPath.row]
        let catModalVC = CatModalViewController(with: catModel)
        catModalVC.delegate = self
        self.lastIndexPath = indexPath
        catModalVC.modalTransitionStyle = .coverVertical
        self.present(catModalVC, animated: true)
    }
}

extension CatFavoritesViewController: CatDelegate {
    func changeStateFavoriteLabel() {
        self.getCats()
    }
}
