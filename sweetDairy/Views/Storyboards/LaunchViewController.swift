//
//  LaunchViewController.swift
//  sweetDairy
//
//  Created by hirapar on 2021/06/15.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var img01 :UIImage = UIImage(named:"orange")!
    var img02 :UIImage = UIImage(named:"choko")!
    var img03 :UIImage = UIImage(named:"monburan")!
    var img04 :UIImage = UIImage(named:"rollcake")!
    
    var imgArray:[UIImage] = []
        /// 一定の間隔で処理を行うためのタイマー
    var timer: Timer?

        override func viewDidLoad() {
            super.viewDidLoad()
            // タイマーを設定
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.onTimer(timer:)), userInfo: nil, repeats: true)
        }

        /// NSTimerによって、一定の間隔で呼び出される関数
    @objc func onTimer(timer: Timer) {

        imageView.image = [img01, img02, img03, img04].randomElement()
        
            // 関数が呼ばれていることを確認
            print("onTimer")
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

}
