import UIKit
import SnapKit

final class CardsEditCollectioViewCell: UICollectionViewCell {
    
    static let identifier = "CardsEditCollectioViewCell"
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 32
        return imageView
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 26
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.isHidden = true
        return view
    }()
    
    // Observers
    var cellBackImage: BackgroundImageForCells? {
        didSet {
            guard let cellImage = cellBackImage else {return}
            
            if let backImgUrl = cellImage.backgImage{
                posterImage.image = UIImage(named: backImgUrl)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(posterImage)
        self.posterImage.addSubview(borderView)
        
        self.setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.posterImage.frame = contentView.bounds
    }
    
    private func setupUI() {
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(self.posterImage.snp.top).offset(6)
            make.leading.equalTo(self.posterImage.snp.leading).offset(6)
            make.trailing.equalTo(self.posterImage.snp.trailing).offset(-6)
            make.bottom.equalTo(self.posterImage.snp.bottom).offset(-6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func toggleSelected () {
        if (isSelected){
            borderView.isHidden = false
        } else {
            borderView.isHidden = true
        }
    }
}
