//
//  HouseViewController.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/11.
//

import UIKit
import RealmSwift
import SDWebImage


class HouseViewController: UIViewController{

    private let refreshControl = UIRefreshControl()
    
    var results: Results<photoData>!
    let realm = try! Realm()
    var number = 0
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "sweetsDairy1")
        imageView.image = image
        self.navigationItem.titleView = imageView
 
        
        results = realm.objects(photoData.self).sorted(byKeyPath: "id", ascending: false)
        number = results.count
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(HouseViewController.refresh(sender:)), for: .valueChanged)
        
        tableView.separatorColor = .white
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        
       // print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //tableView.reloadData()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.backgroundColor = .white
    }
    
    
    @objc func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        refreshControl.endRefreshing()
       }

    
}

extension HouseViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostTableViewCell
        cell.postImageView.image = UIImage(data: results[indexPath.row].pngImage as Data)
             
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = PostContentViewController()
        vc.title = "Post"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.cellNumber = results.count - indexPath.row - 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return tableView.width
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
   
}

extension UIImageView {

    func setImageBySDWebImage(with url: URL) {

        self.sd_setImage(with: url) { [weak self] image, error, _, _ in
            // Success
            if error == nil, let image = image {
                self?.image = image

            // Failure
            } else {
                // error handling

            }
        }

    }
}

