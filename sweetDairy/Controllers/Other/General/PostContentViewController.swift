//
//  PostContentViewController.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/09.
//

import UIKit
import RealmSwift
import Eureka

class PostContentViewController: FormViewController {

    var cellNumber: Int?
    var results: Results<photoData>!
    let realm = try! Realm()
    var postImg : UIImage?
    
    var  postImageView: UIImageView? = {
       let imageView = UIImageView()
       imageView.clipsToBounds = true
       imageView.contentMode = .scaleAspectFill
       return imageView
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results = realm.objects(photoData.self)
       // postImg? = UIImage(data: results[cellNumber!].pngImage as Data)!
       // print(postImg)
        //postImageView?.image = UIImage(data: results[cellNumber!].pngImage as Data)
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        form
            +++ Section() {
                $0.header = {
                    let header = HeaderFooterView<UIImageView>(.callback({ [self] in
                        let view = UIImageView(frame: CGRect(x: 0, y: 0,
                                                        width: self.view.frame.width, height: self.view.frame.width))
                        
                        let imageView2 = UIImage(data: results[cellNumber!].pngImage as Data)!
                        let imageView3 = UIImageView(image:imageView2)
                        let aspectScale = (imageView2.size.height) / (imageView2.size.width)
                        let rect:CGRect = CGRect(x:0, y:0,
                                                 width:self.view.frame.width,
                                                 height: self.view.frame.width * aspectScale)
                        imageView3.frame = rect
                        imageView3.center = CGPoint(x:self.view.frame.width/2, y:self.view.frame.width/2)
                       // let imageView2 = UIImageView(image:postImg)
                        view.addSubview(imageView3)
                        return view
                    }))
                    return header
                }()
            }
            
            <<< TextRow() {
                $0.title = "メニュー:   \(results[cellNumber!].menu ?? "")"
                $0.value = ""
                }.onChange{row in
                   // self.menu = row.value
            }
            
            <<< TextRow() {
                $0.title = "価格:          \(results[cellNumber!].value ?? "")"
                $0.value = ""
                }.onChange{row in
                   // self.value = row.value
            }
            
            <<< TextRow() {
                $0.title = "店名:          \(results[cellNumber!].store ?? "")"
                $0.value = ""
                }.onChange{row in
                   // self.store = row.value
            }
            
            <<< DateRow("") {
                let df = DateFormatter()
                df.dateFormat = "yyyy年MM月dd日"
                let str = df.string(from: results[cellNumber!].date!)
                $0.title = "日付:          \(str)"
                    }.onChange() { row in
                        // 現在のチェック状態
                        print(row.value!)
                }
            
            <<< TextRow() {
                $0.title = "評価:          \(results[cellNumber!].star ?? "")"
                $0.value = ""
                }.onChange{row in
                   // self.store = row.value
            }
        
            
    }
    

}
