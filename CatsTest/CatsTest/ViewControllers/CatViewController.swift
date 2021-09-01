import UIKit

class CatViewController: UIViewController {
    
    var cats = [CatModel]()
    
    private var catsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupConstraints()
        self.getCats()
        self.catsCollectionView.reloadData()
    }
    
    //MARK:- Setup CollectionView & Constraints
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 80)
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
    
    //MARK:- Fetching data
    private func getCats() {
        NetworkService.shared.getCats {(cats) in
            
            cats.forEach { (cat) in
                let catModel = CatModel(with: cat)
                self.cats.append(catModel)
            }
            
            DispatchQueue.main.async {
                self.catsCollectionView.reloadData()
            }
        }
    }
}

//MARK:- Extensions for UI
extension CatViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CatCell.identifier
        let cell = self.catsCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CatCell
        cell.configure(with: self.cats[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let catModel = self.cats[indexPath.row]
        let catModalVC = CatModalViewController(with: catModel)
        catModalVC.modalTransitionStyle = .coverVertical
        self.present(catModalVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 200, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}

//MARK:- Extension for model delegate
extension CatViewController: CatDelegate {
    func changeStateFavoriteLabel() {
        print(self.cats)
    }
}
