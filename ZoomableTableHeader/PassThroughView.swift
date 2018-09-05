//
//  PassThroughView.swift
//  ZoomableTableHeader
//
//  Created by Reona Kubo on 2018/09/05.
//  Copyright © 2018年 Reona Kubo. All rights reserved.
//

import UIKit

class PassThroughView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
}
