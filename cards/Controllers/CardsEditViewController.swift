import UIKit
import SnapKit

//final class CardsEditViewController: UIViewController {
//    
//    private let cardEditView = CardEditView()
//    
//    let cards = DisplayItem(backImgUrl: "small_1_img", balance: "73232 СУМ", cardName: "Рабочая карта", numLabel: "..2341", dateLabel: "09/23", paymentImgUrl: "uzcard")
//    
//    // MARK: - Init
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .systemBackground
//        
//        self.setupCardEditViewUI()
//        
//        self.configureBackgroundImage()
//    }
//    
//    private func setupCardEditViewUI() {
//        self.setupViews()
//        self.setConstraints()
//    }
//    
//    private func setupViews() {
//        self.view.addSubview(cardEditView)
//    }
//    
//    private func setConstraints() {
//        
//        cardEditView.snp.makeConstraints { make in
//            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
//            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
//        }
//    }
//    
//    // MARK: - Methods
//    
//    private func configureBackgroundImage() {
//        self.cardEditView.displayEditItem = cards
//    }
//}
