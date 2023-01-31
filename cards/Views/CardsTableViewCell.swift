import UIKit
import SnapKit

final class CardsTableViewCell: UITableViewCell {

    static let identifier = "CardsTableViewCell"
    
    // Observers
        var displayItem: DisplayItem? {
            didSet {
                guard let displayItem = displayItem else {return}
                
                if let backImgUrl = displayItem.backImgUrl {
                    backgroundImage.image = UIImage(named: backImgUrl)
                }
                
                if let balance = displayItem.balance {
                    balanceLabel.text = "\(balance)"
                }
                      
                if let cardName = displayItem.cardName {
                    aliasLabel.text = "\(cardName)"
                }
                
                if let penImgUrl = displayItem.penImgUrl {
                    penImg.image = UIImage(named: penImgUrl)?.withRenderingMode(.alwaysOriginal)
                }
                
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
    
    // MARK: - Properties of Cell
    
    private let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    /// - Top View, Alias & Icon stackView inside TopView
    private let topView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let aliasLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    private let penImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    /// - Bottom View
    private let bottomView: UIView = {
        let view = UIView()
        return view
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
    
    /// Alpha View
    private let alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 170/255, green: 170/255, blue: 170/255, alpha: 0.12)
        return view
    }()
    
    // MARK: - Init Cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if self.selectedBackgroundView == nil {
            self.selectedBackgroundView = UIView()
        }
        
        self.setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Cell UI
    
    private func setupCellUI() {
        self.setupViews()
        self.setCellConstraints()
    }
    
    private func setupViews() {
        self.contentView.addSubview(cellView)
        self.cellView.addSubview(backgroundImage)
        self.backgroundImage.addSubview(topView)
        self.topView.addSubview(balanceLabel)
        self.topStackView.addArrangedSubview(aliasLabel)
        self.topStackView.addArrangedSubview(penImg)
        self.topView.addSubview(topStackView)
        
        self.backgroundImage.addSubview(bottomView)
        self.cardInfoStackView.addArrangedSubview(numberLabel)
        self.cardInfoStackView.addArrangedSubview(expireLabel)
        self.bottomView.addSubview(cardInfoStackView)
        self.bottomView.addSubview(cardImage)
        
        self.backgroundImage.addSubview(alphaView)
    }
    
    private func setCellConstraints() {
        
        cellView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.leading.equalTo(self.contentView.snp.leading)
            make.trailing.equalTo(self.contentView.snp.trailing)
            make.height.equalTo(202)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(self.cellView.snp.top)
            make.leading.equalTo(self.cellView.snp.leading)
            make.trailing.equalTo(self.cellView.snp.trailing)
            make.bottom.equalTo(self.cellView.snp.bottom)
            make.width.equalTo(self.cellView.snp.width)
            make.height.equalTo(self.cellView.snp.height)
        }
        // ------ Top View ------
        topView.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundImage.snp.top).offset(16)
            make.leading.equalTo(self.backgroundImage.snp.leading).offset(20)
            make.height.equalTo(58)
        }

        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.topView.snp.top)
            make.leading.equalTo(self.topView.snp.leading)
            make.trailing.equalTo(self.topView.snp.trailing)
            make.height.equalTo(32)
        }

        topStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.topView.snp.leading)
            make.trailing.equalTo(self.topView.snp.trailing)
            make.bottom.equalTo(self.topView.snp.bottom)
//            make.width.equalTo(120)
        }
        
        penImg.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 16, height: 16))
        }

        // ----- Bottom View -----
        bottomView.snp.makeConstraints { make in
            make.leading.equalTo(self.backgroundImage.snp.leading).offset(20)
            make.trailing.equalTo(self.backgroundImage.snp.trailing).offset(-20)
            make.bottom.equalTo(self.backgroundImage.snp.bottom).offset(-16)
            make.height.equalTo(40)
        }

        cardInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.bottomView.snp.leading)
            make.bottom.equalTo(self.bottomView.snp.bottom)
        }
        
        cardImage.snp.makeConstraints { make in
            make.top.equalTo(self.bottomView.snp.top).offset(1)
            make.trailing.equalTo(self.bottomView.snp.trailing).offset(-4)
            make.bottom.equalTo(self.bottomView.snp.bottom).offset(-1)
            make.size.equalTo(CGSize(width: 33, height: 38))
        }
        
        // ----- Alpha View -----
        alphaView.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundImage.snp.top)
            make.leading.equalTo(self.backgroundImage.snp.leading)
            make.trailing.equalTo(self.backgroundImage.snp.trailing)
            make.bottom.equalTo(self.backgroundImage.snp.bottom)
        }
    }
}
