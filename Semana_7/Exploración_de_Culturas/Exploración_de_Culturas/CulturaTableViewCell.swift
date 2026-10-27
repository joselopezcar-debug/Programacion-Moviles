//
//  CulturaTableViewCell.swift
//  Exploración_de_Culturas
//
//  Created by Tecsup on 15/10/26.
//

import UIKit

class CulturaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var culturaImagen: UIImageView!
    @IBOutlet weak var culturaNombreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
