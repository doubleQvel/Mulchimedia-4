//
//  ViewControllerCapture.swift
//  Sharman
//
//  Created by Matsumoto Kazuki on 2017/12/22.
//  Copyright © 2017年 Matsumoto Kazuki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerCapture: UIViewController, UIGestureRecognizerDelegate, AVCapturePhotoCaptureDelegate {
    // セッション.
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput: AVCapturePhotoOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewControllerCapture.tapped(_:)))
//        tapGesture.delegate = self
//        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupDisplay()
        setupCamera()
    }
    func setupDisplay(){}
    func setupCamera(){
        // セッションの作成.
        mySession = AVCaptureSession()
        // デバイス一覧の取得.
        myDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
        //撮影時の画面表示
        let videoInput = try! AVCaptureDeviceInput.init(device: myDevice)
        mySession.addInput(videoInput)
        //画像の出力先
        myImageOutput = AVCapturePhotoOutput()
        mySession.addOutput(myImageOutput)
        //画面表示
        let myVideoLayer = AVCaptureVideoPreviewLayer(session: mySession)
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(myVideoLayer)
        //撮影モードの開始
        mySession.startRunning()
        //撮影ボタン作成
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        myButton.backgroundColor = UIColor.blue
        myButton.layer.masksToBounds = true
        myButton.setTitle("撮影", for: .normal)
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        myButton.addTarget(self, action: #selector(ViewControllerCapture.onClickMyButton), for: .touchUpInside)
        self.view.addSubview(myButton);
        //中止ボタン作成
        let stopButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        stopButton.backgroundColor = UIColor.darkGray
        stopButton.layer.masksToBounds = true
        stopButton.setTitle("中止", for: .normal)
        stopButton.layer.cornerRadius = 20.0
        stopButton.layer.position = CGPoint(x: 50, y:self.view.bounds.height-50)
        stopButton.addTarget(self, action: #selector(ViewControllerCapture.onClickStopButton), for: .touchUpInside)
        self.view.addSubview(stopButton);

    }
    func takePicture(){
        //モニター設定
        let settingForMonitoring = AVCapturePhotoSettings()
        settingForMonitoring.flashMode = .auto
        settingForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingForMonitoring.isHighResolutionPhotoEnabled = false
        //
        myImageOutput?.capturePhoto(with: settingForMonitoring, delegate: self)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer){
        takePicture()
    }
    @objc func onClickMyButton(){
        takePicture()
    }
    @objc func onClickStopButton(){
        // camera stop メモリ解放
        mySession.stopRunning()
        let story = UIStoryboard(name: "Screen", bundle: nil)
        let vc = story.instantiateInitialViewController() as! ViewControllerScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //写真撮影後の処理(デリゲート)
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        let imgData = photo.fileDataRepresentation()
        let image = UIImage(data: imgData!)
        //UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
        mySession.stopRunning()
        let story = UIStoryboard(name: "Screen", bundle: nil)
        let vc  = story.instantiateInitialViewController() as! ViewControllerScreen
        vc.GetImage = image
        self.present(vc, animated: true, completion: nil)
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
