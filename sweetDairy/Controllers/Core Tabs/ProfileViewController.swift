//
//  ProfileViewController.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/27.
//

import UIKit
import RealmSwift

final class ProfileViewController: UIViewController {

    private var collectionView: UICollectionView?
    //let models = Model.createModels()
    weak var showImageView: UIImageView!
    
     let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private var userPosts = [UserPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        //let results = realm.objects(Data.self)
       // print(results.count)
        
        
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let size = (view.width - 4)/3
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        
        
        collectionView?.register(PhotoImageCollectionViewCell.self,
                                 forCellWithReuseIdentifier: PhotoImageCollectionViewCell.identifier)
        
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionView?.register(ProfileTabsCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
         
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
           return
        }
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    
    //setttingButtonでプロフィール編集
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    @objc private func didTapSettingsButton() {
        let vc = SettingViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }

    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /*if section == 0 {
            return 0
        }
        return results.count
 
        let realm = try! Realm()
         let results = realm.objects(Data.self)
         //URL型にキャスト
         let fileURL = URL(string: results[0].imageURL!)
         //パス型に変換
         let filePath = fileURL?.path
         showImageView?.image = UIImage(contentsOfFile: filePath!)
 */
         
        // photoImageView.image = showImageView?.image
        return 30//results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let model = userPosts[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoImageCollectionViewCell",
                                                            for: indexPath) as! PhotoImageCollectionViewCell
        cell.image = photoImageView.image
        //cell.configure(with: model)
        //if let cell = cell as? PhotoImageCollectionViewCell {
        //cell.setupCell(model: models[indexPath.row])
       // }
        //cell.photoImageView.image = photoImageView.image
        cell.backgroundColor = .systemOrange
        return cell
    }
 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        //let model = userPosts[indexPath.row]
        let user = User(username: "MK",
                        bio: "",
                        name: (first: "", last: ""),
                        profilePhoto: URL(string: "https://www.google.com")!,
                        birthDate: Date(),
                        gender: .male,
                        counts: UserCount(followers: 1, following: 1, posts: 1),
                        joinDate: Date())
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com/")!,
                            postURL: URL(string: "hyyps://www.google.com/")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createdDate: Date(),
                            taggedUsers: [],
                            owner: user)
        let vc = PostViewController(model: post)
        //vc.title = post.postType.rawValue
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            let tabControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                                                                         for: indexPath) as!
                                                                            ProfileTabsCollectionReusableView
            tabControlHeader.delegate = self
            return tabControlHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier:
                                                                        ProfileInfoHeaderCollectionReusableView.identifier,
                                                                     for: indexPath) as!
                                                                        ProfileInfoHeaderCollectionReusableView
        profileHeader.delegate = self
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width,
                          height: collectionView.height/3)
        }
        
        return CGSize(width: collectionView.width,
                      height: 50)
        
    }
    
}

extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(username: "@MK", namm: "MK", type: x % 2 == 0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "今週"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(username: "@MK", namm: "MK", type: x % 2 == 0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "今月"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "プロフィール編集"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    func didTapGridButtonTab() {
        
    }
    func didTapTaggedButtonTab() {
        
    }
}
