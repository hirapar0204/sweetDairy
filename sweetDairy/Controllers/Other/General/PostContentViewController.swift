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
    //var dele: Results<photoData>!
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
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "post5")
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 176/255, blue: 0/255, alpha: 1)
        
        results = realm.objects(photoData.self)
     //   dele = realm.objects(photoData.self).filter("id == cellNumber")
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
                        let size1: CGFloat = (imageView2.size.height)
                        let size2: CGFloat = (imageView2.size.width)
                        
                        if size2 > size1{
                        
                            
                            let imageView3 = UIImageView(image:imageView2)
                            let aspectScale = (imageView2.size.height) / (imageView2.size.width)
                            let rect:CGRect = CGRect(x:0, y:0,
                                                     width:self.view.frame.width,
                                                     height: self.view.frame.width * aspectScale)
                            imageView3.frame = rect
                            imageView3.center = CGPoint(x:self.view.frame.width/2, y:self.view.frame.width/2)
                            view.addSubview(imageView3)
                            return view
                            
                        }else{
                            let imageView2 = UIImage(data: results[cellNumber!].pngImage as Data)!
                            let imageView3 = UIImageView(image:imageView2)
                            let aspectScale = (imageView2.size.width) / (imageView2.size.height)
                            let rect:CGRect = CGRect(x:0, y:0,
                                                     width:self.view.frame.width * aspectScale,
                                                     height: self.view.frame.width )
                            imageView3.frame = rect
                            imageView3.center = CGPoint(x:self.view.frame.width/2, y:self.view.frame.width/2)
                            view.addSubview(imageView3)
                            return view
                        
                        }
                    }))
                    return header
                }()
            }
            
            <<< TextRow() {
                $0.title = "メニュー:   \(results[cellNumber!].menu ?? "")"
            }
            
            <<< TextRow() {
                $0.title = "価格:          \(results[cellNumber!].value ?? "")"
            }
            
            <<< TextRow() {
                $0.title = "店名:          \(results[cellNumber!].store ?? "")"
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
        
        +++ Section("")
            <<< ButtonRow("Button") {row in
                        row.tag = "delete_row"
                        row.title = "削除"
                        row.onCellSelection{[unowned self] ButtonCellOf, row in
                            let alert = UIAlertController(title: "投稿を削除しますか？", message: "", preferredStyle: .alert)
                            //ここから追加
                            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                                self.dismiss(animated: true, completion: nil)
                                try! realm.write{
                                    realm.delete(results[cellNumber!])
                                }
                                self.navigationController?.popViewController(animated: true)
                            }
                            let no = UIAlertAction(title: "NO", style: .default) { (action) in
                                self.dismiss(animated: true, completion: nil)
                            }
                            alert.addAction(no)
                            alert.addAction(ok)
                            //ここまで追加
                            present(alert, animated: true, completion: nil)
                            
                            
                        }
                    }
        
            
    }//; as! HeaderFooterViewRepresentable
    

}
