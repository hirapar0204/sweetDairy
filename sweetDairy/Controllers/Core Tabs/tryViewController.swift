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
    
     //var image8: UIImage?
     //var data8: Data?
    var results: Results<photoData>!
    
    
     let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let results = realm.objects(photoData.self)
        showImageView.image = UIImage(data: results[0].pngImage as Data)
    }
    


}
