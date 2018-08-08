//
//  XYCollisionView.swift
//  CADisplayLinkTest
//
//  Created by wing on 2018/8/8.
//  Copyright © 2018年 wing. All rights reserved.
//

import UIKit

class XYCollisionView: UIView {

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
