//
//  EditProViewController.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/12.
//

import UIKit
import Eureka
import RealmSwift
import ImageRow

class EditProViewController: FormViewController {

     var name: String?
     var pngImage: NSData!
     var selectedImg = UIImage()
     var nonSelected = UIImage(named: "white")
    
     var old: Results<profileData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Edit")
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = .white
        
        form
            +++ Section("プロフィール設定")
            <<< ImageRow() {
                $0.title = "画像を選択"
                $0.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum, .Camera] // (3)
                $0.value = UIImage(named: "proImage") // (4)
                $0.clearAction = .yes(style: .destructive) // (5)
                $0.onChange { [unowned self] row in // (6)
                    self.selectedImg = row.value!
                }
        }
        
            <<< TextRow() {
                $0.title = "名前の変更"
                $0.value = ""
                }.onChange{row in
                    self.name = row.value
                }
        
    
        +++ Section("")
                <<< ButtonRow("") {row in
                row.title = "設定完了"
                row.onCellSelection{[unowned self] ButtonCellOf, row in
                    if(selectedImg == UIImage() || name == nil){
                    let alert = UIAlertController(title: "詳細を入力してください", message: "", preferredStyle: .alert)
                    //ここから追加
                    let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                       // self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(ok)
                    //ここまで追加
                    present(alert, animated: true, completion: nil)
                }else{
                    let realm = try! Realm()
                    let pngImage = NSData(data:(selectedImg.jpegData(compressionQuality: 0.9)!))
                    let realmData = profileData()
        
         //   if realm.objects(profileData.self).count != 0 {
         //       realmData.id = realm.objects(profileData.self).max(ofProperty: "id")! + 1
         //   }
                    realmData.name = name
                    realmData.pngImage = pngImage
                    //ファイルがどこにあるか見る
                   // print(Realm.Configuration.defaultConfiguration.fileURL!)
                    old = realm.objects(profileData.self).filter("id == 0")
                    let num = old.count
                    try! realm.write {
                        if num == 0 {
                            realm.add(realmData)
                        }else{
                            realm.delete(old)
                            realm.add(realmData)
                        }
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                }
                    
            }
        }

    }
    
    
}

