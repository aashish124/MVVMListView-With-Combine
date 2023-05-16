//
//  ProductCell.swift
//  MVVM ListView
//
//  Created by Aashish Ahlawat on 16/05/23.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var product : Product? {
        didSet {
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration() {
            guard let product else { return }
            productTitleLabel.text = product.title
            productCategoryLabel.text = product.category
            descriptionLabel.text = product.description
            priceLabel.text = "$\(product.price)"
            rateButton.setTitle("\(product.rating.rate)", for: .normal)
            productImageView.setImage(with: product.image)
        }
    
}
