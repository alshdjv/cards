import UIKit
import SnapKit

enum ChainImageState {
    case inactiveCard
    case activeCard
}

final class CardsTableViewCell: UITableViewCell {

    static let identifier = "CardsTableViewCell"
    
    // Observers
        var displayItem: DisplayItem? {
            didSet {
                guard let displayItem = displayItem else {return}
                
                if let backImgUrl = displayItem.backImgUrl {
                    backgroundImg.image = UIImage(named: backImgUrl)
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
    
    // Methods
    public func configure(state: ChainImageState) {
        switch state {
        case .inactiveCard:
            warningView.isHidden = false
            alphaView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        case .activeCard:
            warningView.isHidden = true
            alphaView.backgroundColor = UIColor(displayP3Red: 170/255, green: 170/255, blue: 170/255, alpha: 0.12)
        }
    }
    
    // MARK: - Properties of Cell
    
    private let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let backgroundImg: UIImageView = {
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
        label.font = .systemFont(ofSize: 24, weight: .semibold)
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
    
    private let groupView: UIView = {
        let view = UIView()
        return view
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
        return view
    }()
    
    /// ------ If Card is inActive ------
    private let warningView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.redLight
        view.layer.cornerRadius = 4
        view.layer.isHidden = true
        return view
    }()
    
    private let activeLabel: UILabel = {
        let label = UILabel()
        label.text = "Подключите СМС информирование"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    private let exlamationImage: UIImageView = {
        let image = UIImage(named: "exclamation_img")
        let imageView = UIImageView(image: image?.withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        self.cellView.addSubview(backgroundImg)
        self.backgroundImg.addSubview(topView)
        self.topView.addSubview(balanceLabel)
        self.topView.addSubview(groupView)
        self.groupView.addSubview(aliasLabel)
        self.groupView.addSubview(penImg)
        
        self.backgroundImg.addSubview(bottomView)
        self.cardInfoStackView.addArrangedSubview(numberLabel)
        self.cardInfoStackView.addArrangedSubview(expireLabel)
        self.bottomView.addSubview(cardInfoStackView)
        self.bottomView.addSubview(cardImage)
        
        self.backgroundImg.addSubview(alphaView)
        
        self.cellView.addSubview(warningView)
        self.warningView.addSubview(exlamationImage)
        self.warningView.addSubview(activeLabel)
    }
    
    private func setCellConstraints() {
        
        cellView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.leading.equalTo(self.contentView.snp.leading)
            make.trailing.equalTo(self.contentView.snp.trailing)
            make.height.equalTo(202)
        }
        
        backgroundImg.snp.makeConstraints { make in
            make.top.equalTo(self.cellView.snp.top)
            make.leading.equalTo(self.cellView.snp.leading)
            make.trailing.equalTo(self.cellView.snp.trailing)
            make.bottom.equalTo(self.cellView.snp.bottom)
            make.width.equalTo(self.cellView.snp.width)
            make.height.equalTo(self.cellView.snp.height)
        }
        // ------ Top View ------
        topView.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundImg.snp.top).offset(16)
            make.leading.equalTo(self.backgroundImg.snp.leading).offset(20)
            make.height.equalTo(58)
        }

        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.topView.snp.top)
            make.leading.equalTo(self.topView.snp.leading)
            make.trailing.equalTo(self.topView.snp.trailing)
            make.height.equalTo(32)
        }

        groupView.snp.makeConstraints { make in
            make.leading.equalTo(self.topView.snp.leading)
            make.trailing.equalTo(self.topView.snp.trailing)
            make.bottom.equalTo(self.topView.snp.bottom)
        }
        
        aliasLabel.snp.makeConstraints { make in
            make.top.equalTo(self.groupView.snp.top)
            make.leading.equalTo(self.groupView.snp.leading)
        }
        
        penImg.snp.makeConstraints { make in
            make.top.equalTo(self.groupView.snp.top)
            make.leading.equalTo(self.aliasLabel.snp.trailing).offset(8)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }

        // ----- Bottom View -----
        bottomView.snp.makeConstraints { make in
            make.leading.equalTo(self.backgroundImg.snp.leading).offset(20)
            make.trailing.equalTo(self.backgroundImg.snp.trailing).offset(-20)
            make.bottom.equalTo(self.backgroundImg.snp.bottom).offset(-16)
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
            make.top.equalTo(self.backgroundImg.snp.top)
            make.leading.equalTo(self.backgroundImg.snp.leading)
            make.trailing.equalTo(self.backgroundImg.snp.trailing)
            make.bottom.equalTo(self.backgroundImg.snp.bottom)
        }
        
        // ----- No active cards -----
        warningView.snp.makeConstraints { make in
            make.top.equalTo(self.cellView.snp.top).offset(16)
            make.leading.equalTo(self.cellView.snp.leading).offset(20)
            make.trailing.equalTo(self.cellView.snp.trailing).offset(-20)
        }
        
        exlamationImage.snp.makeConstraints { make in
            make.top.equalTo(self.warningView.snp.top).offset(8)
            make.leading.equalTo(self.warningView.snp.leading).offset(8)
            make.bottom.equalTo(self.warningView.snp.bottom).offset(-8)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        activeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.warningView.snp.top).offset(8)
            make.leading.equalTo(self.exlamationImage.snp.trailing).offset(8)
            make.bottom.equalTo(self.warningView.snp.bottom).offset(-8)
        }
    }
}
