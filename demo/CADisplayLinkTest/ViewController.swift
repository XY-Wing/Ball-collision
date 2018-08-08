//
//  ViewController.swift
//  CADisplayLinkTest
//
//  Created by wing on 2018/8/7.
//  Copyright © 2018年 wing. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    fileprivate var _animator: UIDynamicAnimator?
    fileprivate var _coreMotionMrg: CMMotionManager!
    
    //动画Label
    fileprivate lazy var _animationLab: DWAnimatedLabel = {
        let lab = DWAnimatedLabel(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 30))
        lab.text = "PHP is the best language all over the world!"
        lab.animationType = .typewriter
        lab.textColor = .red
        lab.backgroundColor = .gray
        lab.startAnimation(duration: 8, nil)
        return lab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDynamic()
        setupCoreMotionManager()
        view.addSubview(_animationLab)
    }
    
    fileprivate func setupCoreMotionManager() {

        _coreMotionMrg = CMMotionManager()
        _coreMotionMrg.deviceMotionUpdateInterval = 0.1
        _coreMotionMrg.startDeviceMotionUpdates(to: OperationQueue.current!) { [unowned self]  (m, e) in
            let r = atan2(m!.attitude.pitch, m!.attitude.roll)
            for b in self._animator!.behaviors {
                if b.isKind(of: UIGravityBehavior.self) {
                    (b as! UIGravityBehavior).angle = CGFloat(r)
                    break
                }
            }
        }
    }
    
    fileprivate func setupDynamic() {
        _animator = UIDynamicAnimator(referenceView: self.view)
        
        setupV()
        
        let b1 = UICollisionBehavior(items: self.view.subviews)
        b1.translatesReferenceBoundsIntoBoundary = true
        b1.collisionMode = .everything;
        _animator?.addBehavior(b1)
        
        let g1 = UIGravityBehavior(items: self.view.subviews)
        _animator?.addBehavior(g1)
        
        let i1 = UIDynamicItemBehavior(items: self.view.subviews)
        i1.elasticity = 0.5;
        _animator?.addBehavior(i1)
    }
    
    fileprivate func setupV() {
        
        for _ in 0..<20 {
            let f = arc4random_uniform(376)
            let f2 = arc4random_uniform(100)
            let v1 = XYCollisionView(frame: CGRect(x: CGFloat(f), y: CGFloat(f2), width: 40, height: 40))
            let r = CGFloat(arc4random_uniform(256)) / 255
            let g = CGFloat(arc4random_uniform(100)) / 255
            let b = CGFloat(arc4random_uniform(100)) / 255
            v1.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
            v1.layer.cornerRadius = 20
            v1.layer.masksToBounds = true
            v1.avatarImgName = "avatar.jpg"
            self.view.addSubview(v1)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _animator?.removeAllBehaviors()
        for v in view.subviews {
            v.removeFromSuperview()
        }
        setupDynamic()
    }
    
    deinit {
        _coreMotionMrg.stopDeviceMotionUpdates()
        _coreMotionMrg = nil
    }
}

