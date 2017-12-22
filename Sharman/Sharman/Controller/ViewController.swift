//
//  ViewController.swift
//  Sharman
//
//  Created by Matsumoto Kazuki on 2017/12/15.
//  Copyright © 2017年 Matsumoto Kazuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var TouchName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapMove(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func tapMove(_ gestureRecognizer : UITapGestureRecognizer){
        guard gestureRecognizer.view != nil else { return }
        let story = UIStoryboard(name: "Screen", bundle: nil)
        let vc = story.instantiateInitialViewController() as! ViewControllerScreen
        self.present(vc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

