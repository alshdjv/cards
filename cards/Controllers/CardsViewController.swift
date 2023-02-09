import UIKit
import SnapKit

struct Colors {
    static let redLight = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
    static let blueLight = UIColor(red: 51/255, green: 133/255, blue: 255/255, alpha: 1.0)
}

struct DisplayItem {
    var backImgUrl: String?
    var balance: String?
    var cardName: String?
    var penImgUrl: String?
    var numLabel: String?
    var dateLabel: String?
    var paymentImgUrl: String?
}

// MARK: - Table Cards View Cell

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
            alphaView.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.12)
            alphaView.isHidden = true
        }
    }
}

// MARK: - Main Cards Controller

final class CardsViewController: UIViewController {
    
    let cards = [
        DisplayItem(backImgUrl: "small_3_img", balance: "73232 СУМ", cardName: "Рабочая карта", penImgUrl: "pen_img", numLabel: "..2341", dateLabel: "09/23", paymentImgUrl: "uzcard"),
        DisplayItem(backImgUrl: "small_4_img", balance: "13532 СУМ", cardName: "Не рабочая карта", penImgUrl: "pen_img", numLabel: "..2341", dateLabel: "06/25", paymentImgUrl: "humo"),
        DisplayItem(backImgUrl: "small_2_img", balance: "24532000 СУМ", cardName: "рабочая карта", penImgUrl: "pen_img", numLabel: "..1441", dateLabel: "12/19", paymentImgUrl: "visa"),
        DisplayItem(backImgUrl: "small_1_img", balance: "1000.00 USD", cardName: "Не рабочая карта", penImgUrl: "pen_img", numLabel: "0000 0000 0000 0001", dateLabel: "03/15", paymentImgUrl: "mastercard"),
        DisplayItem(backImgUrl: "small_2_img", balance: "43.55 EU", cardName: "Рабочая карта", penImgUrl: "pen_img", numLabel: "7777 7777 7777 7777", dateLabel: "08/21", paymentImgUrl: "unionpay"),
        DisplayItem(backImgUrl: "small_3_img", balance: "500555 RUB", cardName: "Не рабочая карта", penImgUrl: "pen_img", numLabel: "..44", dateLabel: "02/22", paymentImgUrl: "mir"),
    ]
    
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
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CardsTableViewCell.self, forCellReuseIdentifier: CardsTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.setupTableView()
        self.setupControllerUI()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupControllerUI() {
        self.view.addSubview(cardsLabel)
        self.view.addSubview(subtractButton)
        self.view.addSubview(tableView)
        
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.cardsLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Extensions for Controller

extension CardsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardsTableViewCell.identifier, for: indexPath) as? CardsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        cell.displayItem = cards[indexPath.row]
        cell.configure(state: .activeCard)
        cell.layer.cornerRadius = 12
        return cell
    }

}

extension CardsViewController: CardTableViewCellDidTapCell {
    func cardTableViewCellDidTapCellController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Cards Edit View Controller

final class CardsEditViewController: UIViewController {
    
    private let cardEditView = CardEditView()
    
    let cards = DisplayItem(backImgUrl: "small_1_img", balance: "73232 СУМ", cardName: "Рабочая карта", numLabel: "..2341", dateLabel: "09/23", paymentImgUrl: "uzcard")
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.setupCardEditViewUI()
        
        self.configureBackgroundImage()
    }
    
    private func setupCardEditViewUI() {
        self.setupViews()
        self.setConstraints()
    }
    
    private func setupViews() {
        self.view.addSubview(cardEditView)
    }
    
    private func setConstraints() {
        
        cardEditView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    // Methods
    
    private func configureBackgroundImage() {
        self.cardEditView.displayEditItem = cards
    }
}

// MARK: - Cards Edit View

struct BackgroundImageForCells {
    let backgImage: String?
}

final class CardEditView: UIView {
    
    let cellBackgroundImage = [
        BackgroundImageForCells(backgImage: "small_1_img"),
        BackgroundImageForCells(backgImage: "small_2_img"),
        BackgroundImageForCells(backgImage: "small_3_img"),
        BackgroundImageForCells(backgImage: "small_4_img")
    ]
    
    // MARK: - Properties
    
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
        
        /// Calling Delegate and DataSource Patterns for Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        
        /// Setup View User Interface
        self.setupViewUI()
        self.dismissKey()
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
        
        // Top Content
        backgroundImgView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
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
    
  private func dismissKey() {
      let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(dismissKeyboard))
      tap.cancelsTouchesInView = false
      addGestureRecognizer(tap)
  }

  @objc func dismissKeyboard() {
      self.endEditing(true)
      self.resignFirstResponder()
  }
}

// MARK: - Extensions

extension CardEditView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellBackgroundImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardsEditCollectioViewCell.identifier, for: indexPath) as? CardsEditCollectioViewCell else {
            return UICollectionViewCell()
        }
        cell.cellBackImage = cellBackgroundImage[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CardsEditCollectioViewCell
        selectedCell?.toggleSelected()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let deselected = collectionView.cellForItem(at: indexPath) as? CardsEditCollectioViewCell
        deselected?.toggleSelected()
    }
}

// MARK: - Cards Edit CollectionView Cell

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
            make.top.equalTo(self.posterImage.snp.top).offset(5)
            make.leading.equalTo(self.posterImage.snp.leading).offset(5)
            make.trailing.equalTo(self.posterImage.snp.trailing).offset(-5)
            make.bottom.equalTo(self.posterImage.snp.bottom).offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleSelected () {
        if (isSelected){
            borderView.isHidden = false
        } else {
            borderView.isHidden = true
        }
    }
}
