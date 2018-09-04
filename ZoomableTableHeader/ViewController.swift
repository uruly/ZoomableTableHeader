//
//  ViewController.swift
//  ZoomableTableHeader
//
//  Created by Reona Kubo on 2018/09/05.
//  Copyright © 2018年 Reona Kubo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        let tableView = TableView(frame: CGRect(x:0,y:-statusBarHeight,
                                                width:self.view.frame.width,
                                                height: self.view.frame.height + statusBarHeight))
        self.view.addSubview(tableView)
        
        automaticallyAdjustsScrollViewInsets = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

