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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セッションの作成.
        mySession = AVCaptureSession()
        // デバイス一覧の取得.
        myDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
        
        let videoInput = try! AVCaptureDeviceInput.init(device: myDevice)
        mySession.addInput(videoInput)
        
        myImageOutput = AVCapturePhotoOutput()
        mySession.addOutput(myImageOutput)
        
        let myVideoLayer = AVCaptureVideoPreviewLayer(session: mySession)
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.view.layer.addSublayer(myVideoLayer)
        mySession.startRunning()
        
        
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
        myButton.backgroundColor = UIColor.blue
        myButton.layer.masksToBounds = true
        myButton.setTitle("撮影", for: .normal)
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        myButton.addTarget(self, action: #selector(ViewControllerScreen.onClickMyButton), for: .touchUpInside)
        self.view.addSubview(myButton);
        
    }
    @objc func onClickMyButton(_ sender: Any){
        let settingForMonitoring = AVCapturePhotoSettings()
        settingForMonitoring.flashMode = .auto
        settingForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingForMonitoring.isHighResolutionPhotoEnabled = false
        
        myImageOutput?.capturePhoto(with: settingForMonitoring, delegate: self)
        
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        let imgData = photo.fileDataRepresentation()
        let image = UIImage(data: imgData!)
        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
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
