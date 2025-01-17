

import UIKit

class MealTableViewCell: UITableViewCell {

    private lazy var mealImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var mealName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        heightAnchor.constraint(equalToConstant: 150).isActive = true
        configureImageView()
        configureMealName()
    }
    
    func setUp(with meal: Meal) {
        mealImage.image = meal.image
        mealName.text = meal.name
    }
    
    private func configureImageView() {
        addSubview(mealImage)
        NSLayoutConstraint.activate([
            mealImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mealImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            mealImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            mealImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
    }
    
    private func configureMealName() {
        mealImage.addSubview(mealName)
        NSLayoutConstraint.activate([
            mealName.leftAnchor.constraint(equalTo: mealImage.leftAnchor, constant: 15),
            mealName.bottomAnchor.constraint(equalTo: mealImage.bottomAnchor, constant: -10),
            mealName.rightAnchor.constraint(equalTo: mealImage.rightAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
