//
//  ViewController.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/27.
//

import Eureka
import UIKit
import RealmSwift
import ImageRow

class ViewController: FormViewController {

    var image1: UIImage?
    weak var image2: UIImageView?
    var menu : String? = ""
    var value : String? = ""
    var store : String? = ""
    var date : Date? = nil
    var star : String? = ""
    var pngImage: NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Edit")
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 176/255, blue: 0/255, alpha: 1)
        
        //        configureNavigationBar()
        form
            +++ Section() {
                    $0.header = {
                        let header = HeaderFooterView<UIView>(.callback({ [self] in
                            let view = UIView(frame: CGRect(x: 0, y: 0,
                                                            width: self.view.frame.width, height: self.view.frame.width))
                            
                            let size1: CGFloat = (image1?.size.height)!
                            let size2: CGFloat = (image1?.size.width)!
                            
                            if size2 > size1{
                            
                                let imageView = UIImageView(image:image1)
                                let aspectScale = (image1?.size.height)! / (image1?.size.width)!
                                let rect:CGRect = CGRect(x:0, y:0,
                                                         width:self.view.frame.width,
                                                         height: self.view.frame.width * aspectScale)
                                imageView.frame = rect
                                imageView.center = CGPoint(x:self.view.frame.width/2, y:self.view.frame.width/2)
                                view.addSubview(imageView)
                                return view
                            }else{
                                let imageView = UIImageView(image:image1)
                                let aspectScale = (image1?.size.width)! / (image1?.size.height)!
                                let rect:CGRect = CGRect(x:0, y:0,
                                                         width:self.view.frame.width * aspectScale,
                                                         height: self.view.frame.width )
                                imageView.frame = rect
                                imageView.center = CGPoint(x:self.view.frame.width/2, y:self.view.frame.width/2)
                                view.addSubview(imageView)
                                return view
                            }
                        }))
                        return header
                    }()
            }
            
            <<< TextRow() {
                $0.title = "メニュー"
                $0.value = ""
                }.onChange{row in
                    self.menu = row.value
            }
            
            <<< TextRow() {
                $0.title = "価格"
                $0.value = ""
                }.onChange{row in
                    self.value = row.value
            }
            
            <<< TextRow() {
                $0.title = "店名"
                $0.value = ""
                }.onChange{row in
                    self.store = row.value
            }
            
            <<< DateRow("") {
                    $0.title = "日付を選択"
                    }.onChange() { row in
                        // 現在のチェック状態
                        print(row.value!)
              //          if let value1 = row.value {
              //                  let dateFormatter = DateFormatter()
              //                  dateFormatter.dateFormat = "yyyy-MM-dd"
                            self.date = row.value//Formatter.string(from: value1)
                       // }
                }
        
            <<< PickerInlineRow<String>("評価") { (row : PickerInlineRow<String>) -> Void in
                            row.title = "評価"
                            row.options = ["---", "★★★★★", "★★★★☆", "★★★☆☆", "★★☆☆☆", "★☆☆☆☆"]
                            row.value = row.options[0]
                            row.add(rule: RuleRequired())
                        }.onChange{row in
                            self.star = row.value
                    }
            +++ Section("")
                    <<< ButtonRow("フォームを送信") {row in
                    row.title = "投稿"
                    row.onCellSelection{[unowned self] ButtonCellOf, row in
                        //image2?.image = image1
                        
                        if(menu == nil || value == nil || store == nil || date == nil || star == nil){
                            let alert = UIAlertController(title: "詳細を入力してください", message: "", preferredStyle: .alert)
                            //ここから追加
                            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                                self.dismiss(animated: true, completion: nil)
                            }
                            alert.addAction(ok)
                            //ここまで追加
                            present(alert, animated: true, completion: nil)
                        }else{
                        
                            let realm = try! Realm()
                            let pngImage = NSData(data: (image1?.jpegData(compressionQuality: 0.9)!)!)
                            //var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                           // let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                            let realmData = photoData()
                            
                            
                            
                            
                            /*do{
                                try data.imageURL = documentDirectoryFileURL.absoluteString
                            }catch{
                                print("画像の保存に失敗しました")
                            }
                            func createLocalDataFile() {
                                    // 作成するテキストファイルの名前
                                    let fileName = "\(NSUUID().uuidString).png"
                                    // DocumentディレクトリのfileURL
                                    if documentDirectoryFileURL != nil {
                                        // ディレクトリのパスにファイル名をつなげてファイルのフルパス
                                        let path = documentDirectoryFileURL.appendingPathComponent(fileName)
                                        documentDirectoryFileURL = path
                                    }
                            }
                            func saveImage() {
                                    createLocalDataFile()
                                    //pngで保存
                                    let pngImageData = image2?.image?.pngData()
                                    do {
                                        try pngImageData!.write(to: documentDirectoryFileURL)
                                    } catch {
                                        print("エラー")
                                    }
     
                            }
     */
                            
                            if realm.objects(photoData.self).count != 0 {
                                realmData.id = realm.objects(photoData.self).max(ofProperty: "id")! + 1
                            }
                            realmData.menu = menu
                            realmData.value = value
                            realmData.store = store
                            realmData.date = date
                            realmData.star = star
                            realmData.pngImage = pngImage
                            //ファイルがどこにあるか見る
                          //  print(Realm.Configuration.defaultConfiguration.fileURL!)
                            
                            try! realm.write {
                                realm.add(realmData)
                            }
                            let alert = UIAlertController(title: "投稿完了", message: "", preferredStyle: .alert)
                            //ここから追加
                            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                                self.dismiss(animated: true, completion: nil)
                                self.navigationController?.popViewController(animated: true)
                            }
                            alert.addAction(ok)
                            //ここまで追加
                            present(alert, animated: true, completion: nil)
                            
                        }
                }
                }
    }
    
}
