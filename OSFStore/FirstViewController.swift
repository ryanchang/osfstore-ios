//
//  FirstViewController.swift
//  OSFStore
//
//  Created by Ryan Chang on 14/11/23.
//  Copyright (c) 2014年 CandZen Co., Ltd. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showHUD() {
        SVProgressHUD.showSuccessWithStatus("It works!")
    }
}

