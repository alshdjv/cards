import UIKit
import SnapKit

final class CardEditView: UIView {

    private let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.keyboardDismissMode = .interactive
        return view
    }()
    
    private let contentView: UIView = {
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
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 64, height: 64)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(CardsEditCollectioViewCell.self, forCellWithReuseIdentifier: CardsEditCollectioViewCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        return cv
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
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .systemBackground
        
        /// Notification Center keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        /// Calling Delegate and DataSource Patterns for Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        
        /// Setup View User Interface
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
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        self.contentView.addSubview(backgroundImgView)
        self.contentView.addSubview(balanceLabel)
        self.cardInfoStackView.addArrangedSubview(numberLabel)
        self.cardInfoStackView.addArrangedSubview(expireLabel)
        self.contentView.addSubview(cardInfoStackView)
        self.contentView.addSubview(cardImage)
        self.contentView.addSubview(alphaView)
        self.contentView.addSubview(aliasTextField)
        
        self.contentView.addSubview(captionLabel)
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(saveBtn)
    }
    
    private func setViewConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.snp.top)
            make.leading.equalTo(self.scrollView.snp.leading)
            make.trailing.equalTo(self.scrollView.snp.trailing)
            make.bottom.equalTo(self.scrollView.snp.bottom).priority(250)
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.centerY.equalTo(self.scrollView.snp.centerY).priority(250)
        }
        
        backgroundImgView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(8)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.height.equalTo(self.contentView.snp.width).multipliedBy(10.0 / 17.0)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundImgView.snp.top).offset(16)
            make.leading.equalTo(self.backgroundImgView.snp.leading).offset(20)
            make.height.equalTo(32)
        }
        
        cardInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.backgroundImgView.snp.leading).offset(20)
            make.bottom.equalTo(self.backgroundImgView.snp.bottom).offset(-16)
        }
        
        cardImage.snp.makeConstraints { make in
            make.trailing.equalTo(self.backgroundImgView.snp.trailing).offset(-24)
            make.bottom.equalTo(self.backgroundImgView.snp.bottom).offset(-16)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        // ----- Alpha View -----
        alphaView.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundImgView.snp.top)
            make.leading.equalTo(self.backgroundImgView.snp.leading)
            make.trailing.equalTo(self.backgroundImgView.snp.trailing)
            make.bottom.equalTo(self.backgroundImgView.snp.bottom)
        }
        
        aliasTextField.snp.makeConstraints { make in
            make.top.equalTo(self.balanceLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.balanceLabel.snp.leading)
        }
        
        // Middle Content
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundImgView.snp.bottom).offset(32)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.captionLabel.snp.bottom).offset(16)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.height.equalTo(64)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.top.equalTo(self.collectionView.snp.bottom).offset(40)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.height.equalTo(44)
        }
    }
    
    // MARK: - Methods
    
    @objc func keyboardWillShow(notification:NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 55
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}

// MARK: - Extensions

extension CardEditView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardsEditCollectioViewCell.identifier, for: indexPath) as? CardsEditCollectioViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
