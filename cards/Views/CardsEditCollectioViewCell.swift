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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(posterImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.posterImage.frame = contentView.bounds
    }
}
