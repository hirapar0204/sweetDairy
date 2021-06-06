//
//  PhotoCollectionViewCell.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/05.
//

import UIKit

class PhotoImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoImageCollectionViewCell"
    
    weak var  imgView : UIImageView!
    
    var image: UIImage! {
        didSet {
            imgView?.image = image
        }
    }
}
