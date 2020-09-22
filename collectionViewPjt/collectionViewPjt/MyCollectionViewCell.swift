//
//  MyCollectionViewCell.swift
//  collectionViewPjt
//
//  Created by Amal Joshy on 22/07/20.
//  Copyright © 2020 Amal Joshy. All rights reserved.
//

import UIKit
import SDWebImage

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundViewCell: UIView!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
   
    static let identifier = "MyCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundViewCell.layer.cornerRadius = 4.0
        backgroundViewCell.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4.0
        imageView.layer.masksToBounds = true
    }
    
    //    public func  configure( with image : UIImage){
    //        imageView.image = image
    //        titleLabel.text = "Amal"
    //    }
    
    public func configure(_ image : String, _ name : String){
        imageView.sd_setImage(with: URL(string: image))
        titleLabel.text = name
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
}

struct ContextMenuItem {
    var title = ""
    var image = UIImage()
    var index = 0
}
