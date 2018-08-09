//
//  XYCollisionView.swift
//  CADisplayLinkTest
//
//  Created by wing on 2018/8/8.
//  Copyright © 2018年 wing. All rights reserved.
//

import UIKit
import CoreMotion

class XYCollisionView: UIView {
    
    fileprivate var _animator: UIDynamicAnimator?
    fileprivate var _coreMotionMrg: CMMotionManager!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDynamic()
        setupCoreMotionManager()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - fileprivate
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
        _animator = UIDynamicAnimator(referenceView: self)
        
        setupV()
        
        let b1 = UICollisionBehavior(items: subviews)
        b1.translatesReferenceBoundsIntoBoundary = true
        b1.collisionMode = .everything;
        _animator?.addBehavior(b1)
        
        let g1 = UIGravityBehavior(items: subviews)
        _animator?.addBehavior(g1)
        
        let i1 = UIDynamicItemBehavior(items: subviews)
        i1.elasticity = 0.5;
        _animator?.addBehavior(i1)
    }
    
    fileprivate func setupV() {
        
        for _ in 0..<20 {
            let f = arc4random_uniform(376)
            let f2 = arc4random_uniform(100)
            let v1 = XYCollisionItem(frame: CGRect(x: CGFloat(f), y: CGFloat(f2), width: 40, height: 40))
            let r = CGFloat(arc4random_uniform(256)) / 255
            let g = CGFloat(arc4random_uniform(100)) / 255
            let b = CGFloat(arc4random_uniform(100)) / 255
            v1.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
            v1.layer.cornerRadius = 20
            v1.layer.masksToBounds = true
            v1.avatarImgName = "avatar.jpg"
            addSubview(v1)
        }
        
    }
    
    //MARK: - open
    open func reSetCollisionItems() {
        _animator?.removeAllBehaviors()
        for v in subviews {
            v.removeFromSuperview()
        }
        setupDynamic()
    }
    
    deinit {
        _coreMotionMrg.stopDeviceMotionUpdates()
        _coreMotionMrg = nil
    }
}

//MARK: - 小球类
class XYCollisionItem: UIView {
    //小球对应的图片名称
    open var avatarImgName: String? {
        didSet {
            imgV.image = UIImage(named: avatarImgName!)
        }
    }
    
    fileprivate lazy var imgV: UIImageView = {
        let imgV = UIImageView(frame: self.bounds)
        return imgV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}
