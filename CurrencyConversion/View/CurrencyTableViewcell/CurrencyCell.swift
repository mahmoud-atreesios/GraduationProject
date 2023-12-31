//
//  CurrencyCell.swift
//  CurrencyConversion
//
//  Created by Mahmoud Mohamed Atrees on 24/08/2023.
//

import UIKit

class CurrencyCell: UITableViewCell {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!

    @IBOutlet weak var currencyFlagImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        currencyLabel.font = UIFont(name: "Poppins-Regular", size: 14)
        baseLabel.font = UIFont(name: "Poppins-Regular", size: 12)
        rateLabel.font = UIFont(name: "Poppins-Medium", size: 18)
        // Initialization code
        currencyFlagImageView.makeRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension UIImageView {
    func makeRounded() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}
