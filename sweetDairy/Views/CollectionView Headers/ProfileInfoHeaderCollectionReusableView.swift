//
//  ProfileInfoHeaderCollectionReusableView.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/28.
//

import UIKit
import RealmSwift

protocol  ProfileInfoHeaderCollectionReusableViewDelegate : AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    var prof: Results<photoData>!
    var month: Results<photoData>!
    var week: Results<photoData>!
    var profile: Results<profileData>!
    let realm = try! Realm()
    let screenWidth = UIScreen.main.bounds.size.width
    
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private var profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        //let imageView = UIImage(data: prof[0].pngImage as Data)
        //let imageView1 = UIImageView(image:imageView)//UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 0
        button.setTitle("Posts", for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        //button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 0
        button.setTitle("今週\n", for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        //button.backgroundColor = .secondarySystemBackground

        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 0
        button.setTitle("今月", for: .normal)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        //button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("プロフィール編集", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .clear
        //button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "hirapar"
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "sweets dairy"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let date = Date()
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        var comp = calendar.components([.year, .month, .day], from: date as Date)
        comp.day = 1
        let retDate = calendar.date(from: comp)!
        let date01 = (retDate + 32400)
        
        //print(date01)
        
        let currentDateComponents = calendar.components([.yearForWeekOfYear, .weekOfYear ], from: date as Date)
        let startOfWeek = calendar.date(from: currentDateComponents)!
        let dateSun = (startOfWeek + 32400)
        //print(dateSun)
     

        
        prof = realm.objects(photoData.self).sorted(byKeyPath: "id", ascending: false)
        week = realm.objects(photoData.self).filter("date >= %@", dateSun)
        month = realm.objects(photoData.self).filter("date >= %@", date01)
        profile = realm.objects(profileData.self).sorted(byKeyPath: "id", ascending: false)
        let number = prof.count
        let number2 = profile.count
        let weekCount = week.count
        let monthCount = month.count
       // print(monthCount)
        
        if number2 == 0{
            //何も表示しない
        }else{
        let imageView = UIImage(data: profile[0].pngImage as Data)
        let imageView1 = UIImageView(image:imageView)
            imageView1.contentMode = .scaleAspectFill
            imageView1.clipsToBounds = true
        profilePhotoImageView = imageView1
        }
        
        postsButton.setTitle("トータル\n\(number)個", for: .normal)
        followingButton.setTitle("今月\n\(monthCount)個", for: .normal)
        followersButton.setTitle("今週\n\(weekCount)個", for: .normal)
        
        if number2 == 0{
            nameLabel.text = "noName"
        }else{
            nameLabel.text = "\(profile[0].name ?? "")"
        }
        
        addSubviews()
        addButtonActions()
       // backgroundColor = .systemBackground
        
        clipsToBounds = true
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(postsButton)
        //addSubview(bioLabel)
        addSubview(nameLabel)
        addSubview(editProfileButton)
    }
    
    private func addButtonActions(){
        followersButton.addTarget(self,
                                  action: #selector(didTapFollowerButton),
                                  for: .touchUpInside)
        followingButton.addTarget(self,
                                  action: #selector(didTapFollowingButton),
                                  for: .touchUpInside)
        postsButton.addTarget(self,
                                  action: #selector(didTapPostsButton),
                                  for: .touchUpInside)
        editProfileButton.addTarget(self,
                                  action: #selector(didTapEditProfileButton),
                                  for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor(red: 255/255, green: 176/255, blue: 0/255, alpha: 1)
        //UIColor.gray.withAlphaComponent(0.30)
        //isOpaque = false//.systemGray
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(
            x: 10,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize
        ).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        profilePhotoImageView.clipsToBounds = true
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        
        postsButton.frame = CGRect(
            x: 5 + profilePhotoImageView.right,
            y: (5 + buttonHeight)/2,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followersButton.frame = CGRect(
            x: postsButton.right,
            y: (5 + buttonHeight)/2,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followingButton.frame = CGRect(
            x: followersButton.right,
            y: (5 + buttonHeight)/2,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        editProfileButton.frame = CGRect(
            x: 10,
            y: 55 + profilePhotoImageView.bottom,
            width: screenWidth - 20,
            height: buttonHeight/1.5
        ).integral
        
        nameLabel.frame = CGRect(
            x: 10,
            y: 5 + profilePhotoImageView.bottom,
            width: width-10,
            height: 50
        ).integral
        
  //      let bioLabelSize = bioLabel.sizeThatFits(frame.size)
  //      bioLabel.frame = CGRect(
  //          x: 5,
  //          y: 5 + nameLabel.bottom,
  //          width: width-10,
  //          height: bioLabelSize.height
  //      ).integral
    }
    
    @objc private func didTapFollowerButton(){
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton(){
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapPostsButton(){
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapEditProfileButton(){
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
    
}
