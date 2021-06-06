//
//  ViewController.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/27.
//

import Eureka
import UIKit
import RealmSwift

class ViewController: FormViewController {

    var image1: UIImage?
    weak var image2: UIImageView?
    var menu : String? = ""
    var value : String? = ""
    var store : String? = ""
    var date : String? = ""
    var star : String? = ""
    var str : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureNavigationBar()
        form
            +++ Section() {
                $0.header = {
                    let header = HeaderFooterView<UIView>(.callback({ [self] in
                        let view = UIView(frame: CGRect(x: 0, y: 0,
                                                        width: self.view.frame.width, height: self.view.frame.width))
                        //view.backgroundColor = .blue
                        let imageView = UIImageView(image:image1)
                        let aspectScale = (image1?.size.height)! / (image1?.size.width)!
                        let rect:CGRect = CGRect(x:0, y:0,
                                                 width:self.view.frame.width,
                                                 height: self.view.frame.width * aspectScale)
                        imageView.frame = rect
                        imageView.center = CGPoint(x:self.view.frame.width/2, y:self.view.frame.width/2)
                        view.addSubview(imageView)
                        return view
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
                        let realm = try! Realm()
                        let pngImage = image1?.pngData()
                        str = String(data: pngImage!, encoding: .utf8)
                        //var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                       // let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let realmData = Data()
                        
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
                        
                        if realm.objects(Data.self).count != 0 {
                            realmData.id = realm.objects(Data.self).max(ofProperty: "id")! + 1
                        }
                        realmData.menu = menu
                        realmData.value = value
                        realmData.store = store
                        realmData.star = star
                        realmData.str = str
                        //ファイルがどこにあるか見る
                        //print(Realm.Configuration.defaultConfiguration.fileURL!)
                        
                        try! realm.write {
                            realm.add(realmData)
                        }
                    }
                }
    }
    @objc private func didTapSettingsButton() {
        let vc = SettingViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
}
