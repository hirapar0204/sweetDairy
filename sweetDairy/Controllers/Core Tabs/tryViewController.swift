//
//  tryViewController.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/05.
//

import UIKit
import RealmSwift

class tryViewController: UIViewController {

    @IBOutlet weak var showImageView: UIImageView!
    
     let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
         let results = realm.objects(Data.self)
        print(results)
         //URL型にキャスト
        // let fileURL = URL(string: results[0].imageURL!)
         //パス型に変換
         //let filePath = fileURL?.path
         //showImageView?.image = UIImage(contentsOfFile: filePath!)
        
        // Do any additional setup after loading the view.
    }
    


}
