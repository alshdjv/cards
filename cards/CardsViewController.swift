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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupControllerUI()
    }
    
    private func setupControllerUI() {
        self.view.addSubview(cardsLabel)
        self.view.addSubview(subtractButton)
        
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
    }
    
}

