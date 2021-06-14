//
//  PhotoCollectionViewCell.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/05.
//

import UIKit
import RealmSwift

class PhotoImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoImageCollectionViewCell"
    var result: Results<photoData>!
    weak var showImageView: UIImageView!
    
    
    
    let photoImageView: UIImageView! = {
       let imageView = UIImageView()
       imageView.clipsToBounds = true
       imageView.contentMode = .scaleAspectFill
       return imageView
   }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/*class PhotoImageCollectionViewController: UIViewController{
    
    var result: Results<photoData>!
    weak var showImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        let result = realm.objects(photoData.self)
        showImageView.image = UIImage(data: result[0].pngImage as Data)
    }
 }*/
