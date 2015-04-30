//
//  CircleView.swift
//  CustomViewsInIB
//
//  Created by Douglas Riches on 2015-04-30.
//  Copyright (c) 2015 New Toronto Group. All rights reserved.
//


import UIKit

@IBDesignable

class CircleView: UIView {

    @IBInspectable var lineWidth:CGFloat = 1.0
    @IBInspectable var lineColour:UIColor = UIColor.greenColor()
    
    func setup()
    {
        lineWidth = 1.0
        lineColour = UIColor.blueColor()
    }

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

    }
    
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context:CGContextRef = UIGraphicsGetCurrentContext()
        
        let rect = CGRectMake(0, 0, 200, 200)
        
        CGContextSetLineWidth(context, lineWidth)
        
        CGContextAddEllipseInRect(context, self.bounds )
        
        CGContextSetStrokeColor(context, CGColorGetComponents(lineColour.CGColor))
        
        CGContextStrokePath(context)
        
        
        
    }


}

/*
CGContextRef context = UIGraphicsGetCurrentContext();
CGContextSetLineWidth(context, 4.0);
CGContextSetStrokeColorWithColor(context,
[UIColor blueColor].CGColor);
CGRect rectangle = CGRectMake(60,170,200,80);
CGContextAddEllipseInRect(context, rectangle);
CGContextStrokePath(context);
*/