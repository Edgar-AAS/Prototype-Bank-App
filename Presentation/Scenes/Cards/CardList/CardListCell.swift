import UIKit
import Domain

class CardListCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CardListCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configurateCell()
    }
    
    func setupCell(userCard: UserCard) {
        textLabel?.text = userCard.name
        detailTextLabel?.text = userCard.cardNumber.toSafeCardNumber()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateCell() {
        selectionStyle = .none
        detailTextLabel?.textColor = Colors.secundaryColor
        textLabel?.textColor = .white
        imageView?.image = UIImage(named: "yellowImageCard")
        backgroundColor = Colors.primaryColor
        accessoryType = .disclosureIndicator
    }
}
