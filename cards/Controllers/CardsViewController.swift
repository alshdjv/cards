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
