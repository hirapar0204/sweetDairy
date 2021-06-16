//
//  IGFeedPostTableViewCell.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/28.
//
import RealmSwift
import SDWebImage
import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostTableViewCell"
    var results: Results<photoData>!
    let realm = try! Realm()
    
    
     let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "IGFeedPostTableViewCell")
        contentView.addSubview(postImageView)
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {

    }
    
}


