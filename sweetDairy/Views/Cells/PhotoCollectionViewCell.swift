//
//  PhotoCollectionViewCell.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/28.
//
import RealmSwift
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    weak var showImageView: UIImageView!
    
     let photoImageView: UIImageView = {
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
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*public func configure(with model: UserPost) {
        let url = model.thumbnailImage
        photoImageView.sd_setImage(with: url, completed: nil)
    }
 */
    
    public func configure(debug imageName: String) {
        let realm = try! Realm()
        let results = realm.objects(Data.self)
        //URL型にキャスト
        let fileURL = URL(string: results[0].imageURL!)
        //パス型に変換
        let filePath = fileURL?.path
        showImageView.image = UIImage(contentsOfFile: filePath!)
        
        photoImageView.image = showImageView.image
    }
}
