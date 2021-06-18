//
//  CameraViewController.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/27.
//
import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: UIImage!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "photo2")
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            
            //データが空の場合は画面推移しない
        if photoImageView.image == nil{
                
            let alert = UIAlertController(title: "写真を追加してください", message: "", preferredStyle: .alert)
            //ここから追加
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            //ここまで追加
            present(alert, animated: true, completion: nil)
            
            return false
            }
            //trueを返したときだけ画面遷移する
            return true
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if let nextVC = segue.destination as? ViewController {
                // ファイル名ではなく、画像データを渡す
                photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
                nextVC.image1 = photoImageView.image
            }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoImageView.image = nil
    }
    
 
    
    
    @IBAction func onTappedCameraButton(){
        //presentPickerController(sourceType:.camera)
        let alert = UIAlertController(title: "現在、カメラは使えません", message: "", preferredStyle: .alert)
        //ここから追加
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        //ここまで追加
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sourceType:.photoLibrary)
        
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        self.dismiss(animated: true, completion: nil)
        photoImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            //info[.originalImage]as? UIImage
        photoImageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        //self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    func resize(photo: UIImage, width: Double) -> UIImage {
            
        // オリジナル画像のサイズからアスペクト比を計算
        let aspectScale = photo.size.height / photo.size.width
        
        // widthからアスペクト比を元にリサイズ後のサイズを取得
        let resizedSize = CGSize(width: width, height: width * Double(aspectScale))
        
        // リサイズ後のUIImageを生成して返却
        UIGraphicsBeginImageContext(resizedSize)
        photo.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
 */
    
 

}
