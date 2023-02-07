import UIKit
import SnapKit

final class CardEditView: UIView {
    
    // Properties
    private let mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let backgroundImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    private let expireLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    private let cardInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        return stackView
    }()
    
    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var displayEditItem: DisplayItem? {
        didSet {
            guard let displayItem = displayEditItem else {return}

            if let backImgUrl = displayItem.backImgUrl {
                backgroundImgView.image = UIImage(named: backImgUrl)
            }

            if let balance = displayItem.balance {
                balanceLabel.text = "\(balance)"
            }

//            if let cardName = displayItem.cardName {
//                aliasLabel.text = "\(cardName)"
//            }

//            if let penImgUrl = displayItem.penImgUrl {
//                penImg.image = UIImage(named: penImgUrl)?.withRenderingMode(.alwaysOriginal)
//            }

            if let numLabel = displayItem.numLabel {
                numberLabel.text = "\(numLabel)"
            }

            if let dateLabel = displayItem.dateLabel {
                expireLabel.text = "\(dateLabel)"
            }

            if let paymentImgUrl = displayItem.paymentImgUrl {
                cardImage.image = UIImage(named: paymentImgUrl)?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        self.setupViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View UI
    
    private func setupViewUI() {
        self.setupViews()
        self.setViewConstraints()
    }
    
    private func setupViews() {
        self.addSubview(mainView)
        self.mainView.addSubview(backgroundImgView)
        self.mainView.addSubview(balanceLabel)
        self.cardInfoStackView.addArrangedSubview(numberLabel)
        self.cardInfoStackView.addArrangedSubview(expireLabel)
        self.mainView.addSubview(cardInfoStackView)
        self.mainView.addSubview(cardImage)
    }
    
    private func setViewConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.height.equalTo(self.snp.width).multipliedBy(10.0 / 17.0)
        }
        
        backgroundImgView.snp.makeConstraints { make in
            make.top.equalTo(self.mainView.snp.top)
            make.leading.equalTo(self.mainView.snp.leading)
            make.trailing.equalTo(self.mainView.snp.trailing)
            make.bottom.equalTo(self.mainView.snp.bottom)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.mainView.snp.top).offset(16)
            make.leading.equalTo(self.mainView.snp.leading).offset(20)
            make.height.equalTo(32)
        }
        
        cardInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.mainView.snp.leading).offset(20)
            make.bottom.equalTo(self.mainView.snp.bottom).offset(-16)
        }
        
        cardImage.snp.makeConstraints { make in
            make.trailing.equalTo(self.mainView.snp.trailing).offset(-24)
            make.bottom.equalTo(self.mainView.snp.bottom).offset(-16)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
}
