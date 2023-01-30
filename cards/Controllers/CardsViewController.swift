import UIKit
import SnapKit

class CardsViewController: UIViewController {
    
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
        self.view.backgroundColor = .white
        
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
            make.top.equalTo(self.cardsLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Extensions for Controller

extension CardsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardsTableViewCell.identifier, for: indexPath) as? CardsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "Hello"
        return cell
    }
}
