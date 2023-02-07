import UIKit
import SnapKit

final class CardEditView: UIView {
    
    // Top Data
    private let topView: UIView = {
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
    
    private let aliasTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        textField.font = .systemFont(ofSize: 15, weight: .semibold)
        textField.becomeFirstResponder()
        return textField
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
    
    private let alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.layer.cornerRadius = 12
        return view
    }()
    
    // Middle Data
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Дизайн карты"
        label.textColor = UIColor(red: 170/255, green: 171/255, blue: 173/255, alpha: 1.0)
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let saveBtn: UIButton = {
        let button = UIButton()
        let btnTitle = "Сохранить"
        button.setTitle(btnTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        button.backgroundColor = Colors.blueLight
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    
    // Observers
    var displayEditItem: DisplayItem? {
        didSet {
            guard let displayItem = displayEditItem else {return}

            if let backImgUrl = displayItem.backImgUrl {
                backgroundImgView.image = UIImage(named: backImgUrl)
            }

            if let balance = displayItem.balance {
                balanceLabel.text = "\(balance)"
            }

            if let cardName = displayItem.cardName {
                aliasTextField.text = "\(cardName)"
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
        self.addSubview(topView)
        self.topView.addSubview(backgroundImgView)
        self.topView.addSubview(balanceLabel)
        self.cardInfoStackView.addArrangedSubview(numberLabel)
        self.cardInfoStackView.addArrangedSubview(expireLabel)
        self.topView.addSubview(cardInfoStackView)
        self.topView.addSubview(cardImage)
        self.topView.addSubview(alphaView)
        self.topView.addSubview(aliasTextField)
        
        self.addSubview(captionLabel)
        self.addSubview(saveBtn)
    }
    
    private func setViewConstraints() {
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.height.equalTo(self.snp.width).multipliedBy(10.0 / 17.0)
        }
        
        backgroundImgView.snp.makeConstraints { make in
            make.top.equalTo(self.topView.snp.top)
            make.leading.equalTo(self.topView.snp.leading)
            make.trailing.equalTo(self.topView.snp.trailing)
            make.bottom.equalTo(self.topView.snp.bottom)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.topView.snp.top).offset(16)
            make.leading.equalTo(self.topView.snp.leading).offset(20)
            make.height.equalTo(32)
        }
        
        cardInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.topView.snp.leading).offset(20)
            make.bottom.equalTo(self.topView.snp.bottom).offset(-16)
        }
        
        cardImage.snp.makeConstraints { make in
            make.trailing.equalTo(self.topView.snp.trailing).offset(-24)
            make.bottom.equalTo(self.topView.snp.bottom).offset(-16)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        // ----- Alpha View -----
        alphaView.snp.makeConstraints { make in
            make.top.equalTo(self.topView.snp.top)
            make.leading.equalTo(self.topView.snp.leading)
            make.trailing.equalTo(self.topView.snp.trailing)
            make.bottom.equalTo(self.topView.snp.bottom)
        }
        
        aliasTextField.snp.makeConstraints { make in
            make.top.equalTo(self.balanceLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.balanceLabel.snp.leading)
        }
        
        // Middle Content
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundImgView.snp.bottom).offset(32)
            make.leading.equalTo(self.snp.leading).offset(16)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.bottom.equalTo(self.snp.bottom).offset(-55)
            make.height.equalTo(44)
        }
    }
    
    // MARK: - Methods
    
}
