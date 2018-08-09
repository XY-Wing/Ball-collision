//
//  ViewController.swift
//  CADisplayLinkTest
//
//  Created by wing on 2018/8/7.
//  Copyright © 2018年 wing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate lazy var _collisionV: XYCollisionView = {
        let c = XYCollisionView(frame: view.bounds)
        return c
    }()
    
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
        view.addSubview(_animationLab)
        view.addSubview(_collisionV)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _collisionV.reSetCollisionItems()
    }
    
    
}

