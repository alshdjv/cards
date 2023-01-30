import UIKit
import SnapKit

class CardsTableViewCell: UITableViewCell {

    static let identifier = "CardsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if self.selectedBackgroundView == nil {
            self.selectedBackgroundView = UIView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
