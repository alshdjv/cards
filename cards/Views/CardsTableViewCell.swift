import UIKit
import SnapKit

protocol CardTableViewCellDidTapCell: AnyObject {
    func cardTableViewCellDidTapCellController(_ viewController: UIViewController)
}

enum ChainImageState {
    case inactiveCard
    case activeCard
}

final class CardsTableViewCell: UITableViewCell {

    static let identifier = "CardsTableViewCell"
    
    public weak var delegate: CardTableViewCellDidTapCell?
    
    // MARK: - Properties of Cell
    
    private let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let backgroundImg: UIImageView = {
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
    
    private let pushButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    @objc func pushButtonTapped(_ sender: AnyObject) {
        self.delegate?.cardTableViewCellDidTapCellController(CardsEditViewController())
    }
    
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
        view.isHidden = true
        view.layer.cornerRadius = 12
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
    
    // MARK: - Init Cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemBackground
        
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
        self.cellView.addSubview(balanceLabel)
        self.cellView.addSubview(aliasLabel)
        self.cellView.addSubview(penImg)
        
        self.cellView.addSubview(pushButton)
        pushButton.addTarget(self, action: #selector(pushButtonTapped), for: .touchUpInside)
        
        self.cardInfoStackView.addArrangedSubview(numberLabel)
        self.cardInfoStackView.addArrangedSubview(expireLabel)
        self.cellView.addSubview(cardInfoStackView)
        self.cellView.addSubview(cardImage)
        
        self.cellView.addSubview(alphaView)
        
        self.cellView.addSubview(warningView)
        self.warningView.addSubview(exlamationImage)
        self.warningView.addSubview(activeLabel)
    }
    
    private func setCellConstraints() {
        
        cellView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).inset(12)
            make.leading.trailing.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).inset(12).priority(.init(999))
            make.height.equalTo(self.contentView.snp.width).multipliedBy(10.0 / 17.0)
        }
        
        backgroundImg.snp.makeConstraints { make in
            make.top.equalTo(self.cellView.snp.top)
            make.leading.equalTo(self.cellView.snp.leading)
            make.trailing.equalTo(self.cellView.snp.trailing)
            make.bottom.equalTo(self.cellView.snp.bottom)
        }

        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cellView.snp.top).offset(16)
            make.leading.equalTo(self.cellView.snp.leading).offset(20)
            make.height.equalTo(32)
        }
        
        aliasLabel.snp.makeConstraints { make in
            make.top.equalTo(self.balanceLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.balanceLabel.snp.leading)
        }
        
        penImg.snp.makeConstraints { make in
            make.top.equalTo(self.balanceLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.aliasLabel.snp.trailing).offset(8)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        pushButton.snp.makeConstraints { make in
            make.top.equalTo(self.penImg.snp.top)
            make.leading.equalTo(self.penImg.snp.leading)
            make.trailing.equalTo(self.penImg.snp.trailing)
            make.bottom.equalTo(self.penImg.snp.bottom)
            make.width.equalTo(self.penImg.snp.width)
            make.height.equalTo(self.penImg.snp.height)
        }

        cardInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.cellView.snp.leading).offset(20)
            make.bottom.equalTo(self.cellView.snp.bottom).offset(-16)
        }
        
        cardImage.snp.makeConstraints { make in
            make.trailing.equalTo(self.cellView.snp.trailing).offset(-24)
            make.bottom.equalTo(self.cellView.snp.bottom).offset(-16)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        // ----- Alpha View -----
        alphaView.snp.makeConstraints { make in
            make.top.equalTo(self.cellView.snp.top)
            make.leading.equalTo(self.cellView.snp.leading)
            make.trailing.equalTo(self.cellView.snp.trailing)
            make.bottom.equalTo(self.cellView.snp.bottom)
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
    
    // MARK: - Methods
    
    public func configure(state: ChainImageState) {
        switch state {
        case .inactiveCard:
            warningView.isHidden = false
            alphaView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            alphaView.isHidden = false
        case .activeCard:
            warningView.isHidden = true
            alphaView.backgroundColor = UIColor(displayP3Red: 170/255, green: 170/255, blue: 170/255, alpha: 0.12)
            alphaView.isHidden = true
        }
    }
}
