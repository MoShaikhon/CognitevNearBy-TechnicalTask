//
//  UIView+Anchoring.swift
//  JSON
//
//  Created by Mohamed Shaikhon on 3/10/18.
//  Copyright © 2018 Mohamed Shaikhon. All rights reserved.
//

import UIKit

// MARK: - a UIView extension containing Autolayout anchoring methods (for convenience)
extension UIView {
    
    func anchorYAxis(top:NSLayoutYAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0) {
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant)
                .isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant)
                .isActive = true
        }
    }
    func anchorYAxisLessOrEqualTo(top:NSLayoutYAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil) {
        if let top = top {
            topAnchor.constraint(lessThanOrEqualTo: top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(lessThanOrEqualTo: bottom).isActive = true
        }
    }
    func anchorXAxis(leading:NSLayoutXAxisAnchor? = nil, trailing:NSLayoutXAxisAnchor? = nil, leadingConstant: CGFloat = 0, trailingConstant: CGFloat = 0) {
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leadingConstant)
                .isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: trailingConstant)
                .isActive = true
        }
    }
    
    func anchorCenter(horizontal:NSLayoutXAxisAnchor? = nil, vertical:NSLayoutYAxisAnchor? = nil, xConstant: CGFloat, yConstant: CGFloat) {
        if let horizontal = horizontal {
            centerXAnchor.constraint(equalTo: horizontal, constant: xConstant)
                .isActive = true
        }
        if let vertical = vertical {
            centerYAnchor.constraint(equalTo: vertical, constant: yConstant)
                .isActive = true
        }
    }
    func anchorWidth(equalToConstant: CGFloat)  {
        widthAnchor.constraint(equalToConstant: equalToConstant)
            .isActive = true
    }
    func anchorHeight(equalToConstant: CGFloat)  {
        heightAnchor.constraint(equalToConstant: equalToConstant)
            .isActive = true
    }
    
    func anchorWidth(width: NSLayoutDimension, multiplier:CGFloat , constant: CGFloat)  {
        widthAnchor.constraint(equalTo: width, multiplier: multiplier, constant: constant)
            .isActive = true
    }
    func anchorHeight(height: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat)  {
        heightAnchor.constraint(equalTo: height, multiplier: multiplier, constant: constant)
            .isActive = true
        
    }
    func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

