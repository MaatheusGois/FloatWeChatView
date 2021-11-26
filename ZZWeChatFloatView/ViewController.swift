//
//  ViewController.swift
//  ZZWeChatFloatView
//
//  Created by 周晓瑞 on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    fileprivate func setup() {
        title = "Safari view"
        view.backgroundColor = .white

        FloatViewManager.manager.ballView.show = true
    }
}
