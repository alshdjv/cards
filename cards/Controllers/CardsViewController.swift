import UIKit
import SnapKit

class CardsViewController: UIViewController {
    
    private let cardsLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои карты"
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        return label
    }()

    private let subtractButton: UIButton = {
        let image = UIImage(named: "subtract_img")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CardsCollectionViewCell.self, forCellWithReuseIdentifier: CardsCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupControllerUI()
    }
    
    private func setupControllerUI() {
        self.view.addSubview(cardsLabel)
        self.view.addSubview(subtractButton)
        self.view.addSubview(collectionView)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        
        cardsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }

        subtractButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.cardsLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}

