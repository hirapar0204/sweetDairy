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
       // configureNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let nextVC = segue.destination as? ViewController {
                // ファイル名ではなく、画像データを渡す
                photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
                nextVC.image1 = photoImageView.image
            }
    }
    
    
    @IBAction func onTappedCameraButton(){
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sourceType: .photoLibrary)
        
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
        photoImageView.image = info[.originalImage]as? UIImage
        photoImageView.contentMode = UIView.ContentMode.scaleAspectFit
        
    }
    
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
    
    /*private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(systemName:"gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() {
        let vc = UIStoryboard(name: "ExploreViewController", bundle: nil).instantiateInitialViewController() as! ExploreViewController
        vc.title = "Settings"
        //画面移動
        navigationController?.pushViewController(vc, animated: true)
    }
 */
    

}
