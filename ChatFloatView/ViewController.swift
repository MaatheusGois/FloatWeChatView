//
//  ViewController.swift
//  ChatFloatView
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

    fileprivate func setup() {
        title = "Safari view"
        view.backgroundColor = .white

        FloatViewManager.shared.setup(with: .init(string: "https://www.google.com")!)
        buildButton()
    }

    fileprivate func buildButton() {
        if #available(iOS 13.0, *) {
            addLeftBarButton(buttonImage: .actions) {
                FloatViewManager.shared.ballView.show.toggle()
            }
        }
    }

    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .systemBlue
    }
}
