//
//  NewDetailController.swift
//  ZZWeChatFloatView
//
//  Created by 周晓瑞 on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

import SafariServices

class NewSafariController: SFSafariViewController {
    var themeColor: UIColor?

    init(url: URL) {
        super.init(
            url: url,
            configuration: .default
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredBarTintColor = .black
        preferredControlTintColor = .white
    }
}

// MARK: - Extensions

 fileprivate extension SFSafariViewController.Configuration {
     static var `default`: Self {
         let config = Self()
         config.entersReaderIfAvailable = true
         return config
     }
 }
