//
//  HouseViewController.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/11.
//

import UIKit
import RealmSwift

struct HouseFeedRenderViewModel {
    let post: PostRenderViewModel
}

class HouseViewController: UIViewController{

    private var feedRenderModels = [HouseFeedRenderViewModel]()
    
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
        
        results = realm.objects(photoData.self).sorted(byKeyPath: "id", ascending: false)
        number = results.count
        
        tableView.separatorColor = .white
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        
       // print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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

