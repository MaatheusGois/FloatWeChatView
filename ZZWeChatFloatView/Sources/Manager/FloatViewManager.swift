//
//  ZZFloatViewManager.swift
//  ZZWeChatFloatView
//
//  Created by 周晓瑞 on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

final class FloatViewManager: NSObject {

    // Properties

    static let shared = FloatViewManager()

    public let bottomFloatView = BottomFloatView()
    public let ballView = FloatBallView()
    public let ballRedCancelView = BottomFloatView()

    private var floatViewController: NewSafariController?

    required override init() {
        super.init()
        currentNavigationController()?.delegate = self

        setup()
        ballMoveEvents()
    }

    public func setup(with url: URL) {
        floatViewController = .init(url: url)
    }

    private func setup() {
        bottomFloatView.frame = .init(x: DSFloatChat.screenWidth, y: DSFloatChat.screenHeight, width: DSFloatChat.bottomViewFloatWidth, height: DSFloatChat.bottomViewFloatHeight)
        DSFloatChat.window?.addSubview(bottomFloatView)

        ballRedCancelView.frame = .init(x: DSFloatChat.screenWidth, y: DSFloatChat.screenHeight, width: DSFloatChat.bottomViewFloatWidth, height: DSFloatChat.bottomViewFloatHeight)
        ballRedCancelView.type = BottomFloatViewType.red
        DSFloatChat.window?.addSubview(ballRedCancelView)

        ballView.frame = DSFloatChat.ballRect
        ballView.delegate = self
    }

    func ballMoveEvents() {
        // Circular reference
        ballView.ballDidSelect = { [weak self] in
            guard
                let self = self,
                let viewController = self.floatViewController
            else { return }
            // Prevent clicks
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.currentNavigationController()?.pushViewController(viewController, animated: true)
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

extension FloatViewManager: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {

        // Animate only for effect VCs, ignore other VCs
        if operation == .push {
            guard toVC == floatViewController else { return nil }
            return TransitionPush()

        } else if operation == .pop {
            guard fromVC == floatViewController else { return nil }
            return TransitionPop()

        } else {
            return nil
        }
    }
}

extension FloatViewManager: FloatViewDelegate {
    func floatViewBeginMove(floatView: FloatBallView, point: CGPoint) {
        UIView.animate(withDuration: 0.2, animations: {
            self.ballRedCancelView.frame = CGRect(
                x: DSFloatChat.screenWidth - DSFloatChat.bottomViewFloatWidth,
                y: DSFloatChat.screenHeight - DSFloatChat.bottomViewFloatHeight,
                width: DSFloatChat.bottomViewFloatWidth,
                height: DSFloatChat.bottomViewFloatHeight
            )
        }) { _ in }
    }

    func floatViewMoved(floatView: FloatBallView, point: CGPoint) {
        guard let transformBottomP = DSFloatChat.window?.convert(ballView.center, to: ballRedCancelView) else {
            return
        }

        if transformBottomP.x > .zero && transformBottomP.y > .zero {
            let arcCenter = CGPoint(x: DSFloatChat.bottomViewFloatWidth, y: DSFloatChat.bottomViewFloatHeight)
            let distance = pow((transformBottomP.x - arcCenter.x), 2) + pow((transformBottomP.y - arcCenter.y), 2)
            let onArc = pow(arcCenter.x, 2)

            if distance <= onArc {
                if !ballRedCancelView.insideBottomSelected {
                    ballRedCancelView.insideBottomSelected = true
                }
            } else {
                if ballRedCancelView.insideBottomSelected {
                    ballRedCancelView.insideBottomSelected = false
                }
            }
        } else {
            if ballRedCancelView.insideBottomSelected {
                ballRedCancelView.insideBottomSelected = false
            }
        }
    }

    func floatViewCancelMove(floatView: FloatBallView) {
        if ballRedCancelView.insideBottomSelected {
            ballView.show = false
        }

        UIView.animate(withDuration: DSFloatChat.animationCancelMoveDuration, animations: {
            self.ballRedCancelView.frame = .init(
                x: DSFloatChat.screenWidth,
                y: DSFloatChat.screenHeight,
                width: DSFloatChat.bottomViewFloatWidth,
                height: DSFloatChat.bottomViewFloatHeight
            )
        }) { _ in }
    }
}
