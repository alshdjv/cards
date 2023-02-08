import UIKit
import SnapKit

final class CardsEditCollectioViewCell: UICollectionViewCell {
    
    static let identifier = "CardsEditCollectioViewCell"
    
    private let posterImage: UIImageView = {
        let image = UIImage(named: "small_4_img")
        let imageView = UIImageView(image: image?.withRenderingMode(.alwaysOriginal))
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
    
    private func setupUI() {
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(self.posterImage.snp.top).offset(6)
            make.leading.equalTo(self.posterImage.snp.leading).offset(6)
            make.trailing.equalTo(self.posterImage.snp.trailing).offset(-6)
            make.bottom.equalTo(self.posterImage.snp.bottom).offset(-6)
//            make.size.equalTo(CGSize(width: 52, height: 52))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.posterImage.frame = contentView.bounds
    }
}
