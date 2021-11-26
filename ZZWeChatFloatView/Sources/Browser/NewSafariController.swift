//
//  NewDetailController.swift
//  ZZWeChatFloatView
//
//  Created by 周晓瑞 on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

import SafariServices

class NewSafariController: SFSafariViewController {

    init(url: URL) {
        super.init(
            url: url,
            configuration: .default
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // Private Methods

    private func setup() {
        setupStyle()
    }

    private func setupStyle() {
        preferredBarTintColor = .black
        preferredControlTintColor = .white
    }

    private func setupNavigation() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .init(hex: "131313")
        navigationController?.navigationBar.alpha = 1
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white

        addLeftBarButton(buttonImage: .init(named: "close")) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            FloatViewManager.shared.ballView.show = false
        }

        addRightBarButton(buttonImage: .init(named: "compress")) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
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
