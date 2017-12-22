//
//  ViewControllerScreen.swift
//  Sharman
//
//  Created by Matsumoto Kazuki on 2017/12/15.
//  Copyright © 2017年 Matsumoto Kazuki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerScreen: UIViewController, AVCapturePhotoCaptureDelegate {
    // セッション.
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput: AVCapturePhotoOutput!
    @IBOutlet weak var selectingText: UILabel!
    @IBOutlet weak var selectedCamera: UIButton!
    @IBOutlet weak var selectedPicture: UIButton!
    var GetImage:UIImage? = nil
    @IBOutlet weak var CaptureView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CaptureView.isHidden = true
        //漫画にしたい写真の選択方法のボタン
        selectedCamera.addTarget(self, action: #selector(ViewControllerScreen.modeCamera), for: .touchUpInside)
        selectedPicture.addTarget(self, action: #selector(ViewControllerScreen.modePicture), for: .touchUpInside)
        if GetImage != nil{
            //画像の表示
            initDisplayPicture()
            //ボタンの表示
            makingButton()
        }
    }
    func makingButton(){
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        myButton.backgroundColor = UIColor.blue
        myButton.layer.masksToBounds = true
        myButton.setTitle("2値化", for: .normal)
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        myButton.addTarget(self, action: #selector(ViewControllerScreen.onClickMyButton), for: .touchUpInside)
        self.view.addSubview(myButton);
    }
    func initDisplayPicture(){
        let screenWidth:CGFloat = CaptureView.bounds.width
        let screenHeight:CGFloat = CaptureView.bounds.height
        CaptureView.isHidden = false
        CaptureView.image = GetImage!
        var transScale = CGAffineTransform()
        transScale = CGAffineTransform(scaleX: 1, y: 1)
        CaptureView.transform = transScale
        CaptureView.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
    }
    func getByteArrayFromImage(imageRef: CGImage) -> [UInt8] {
        let data = imageRef.dataProvider!.data
        let length = CFDataGetLength(data)
        var rawData = [UInt8](repeating: 0, count: length)
        CFDataGetBytes(data, CFRange(location: 0, length: length), &rawData)
        return rawData
        
    }
    //カメラモード選択
    @objc func modeCamera(_ sender: Any){
        let story = UIStoryboard(name: "Capture", bundle: nil)
        let vc = story.instantiateInitialViewController() as! ViewControllerCapture
        self.present(vc, animated: true, completion: nil)
    }
    //写真モード選択
    @objc func modePicture(_ sender: Any){
    }
    //２値化時の処理
    @objc func onClickMyButton(_ sender: Any){
        //ピクセル値の取得
        let pixels = GetImage!.cgImage!.bitsPerComponent
        //コピー元の作成
        var makeImage:UIImage
        let gaso = UIImagePNGRepresentation(GetImage!)!
//        for item in gaso{
//            selectingText.text = String(item)
//            self.view.addSubview(selectingText)
//        }
        selectingText.text = "\(gaso[0])"
        self.view.addSubview(selectingText)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
