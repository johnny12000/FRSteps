//
//  FRSteps.swift
//
//  Created by Nikola Ristic on 4/20/17.
//  Copyright © 2017 nr. All rights reserved.
//

import UIKit

@IBDesignable
open class FRSteps: UIView {

    /// Number of all steps in the process
    @IBInspectable
    var numberOfSteps: Int = 2 {
        didSet {
            initializeControl()
        }
    }

    /// Current step number
    @IBInspectable
    var currentStep: Int = 1 {
        didSet {
            initializeControl()
        }
    }

    /// Color of inactive dots and connector
    @IBInspectable
    var inactiveDotColor: UIColor = UIColor.black {
        didSet {
            initializeControl()
        }
    }

    /// Image of steps
    var stepsImage: UIImageView?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeControl()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeControl()
    }

    // MARK: - Utilities methods

    func initializeControl() {
        backgroundColor = UIColor.clear
        stepsImage?.removeFromSuperview()
        if let image = createStepsImage(size: frame.size) {
            stepsImage = UIImageView(image: image)
            addSubview(stepsImage!)
        }
    }

    func createStepsImage(size: CGSize) -> UIImage? {
        let dotSize = CGSize(width: 20, height: 20)
        let smallDotSize = CGSize(width: 10, height: 10)

        let oneDotSpace = frame.width / CGFloat(numberOfSteps)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        let lineHeight: CGFloat = 3
        for i in 1...numberOfSteps - 1 {
            let x = (CGFloat(i) - 0.5) * oneDotSpace + dotSize.width / 2
            let y = size.height / 2 - lineHeight / 2
            let width = oneDotSpace - dotSize.width
            let lineRect = CGRect(x: x, y: y, width: width, height: lineHeight)
            let line = UIBezierPath(rect: lineRect)
            inactiveDotColor.setStroke()
            inactiveDotColor.setFill()
            line.stroke()
            line.fill()
        }

        for i in 1...numberOfSteps {
            let x: CGFloat = (CGFloat(i) - 0.5) * oneDotSpace - dotSize.width / 2
            let y: CGFloat = size.height / 2 - dotSize.height / 2
            var dotColor: UIColor = inactiveDotColor
            if i == currentStep {
                dotColor = tintColor

                let circle = UIBezierPath(ovalIn: CGRect(x: x, y: y,
                                                         width: dotSize.width, height: dotSize.height))
                circle.lineWidth = 2
                dotColor.setStroke()
                circle.stroke()

                let circle1 = UIBezierPath(ovalIn: CGRect(x: x + 5, y: y + 5,
                                                          width: smallDotSize.width, height: smallDotSize.height))
                circle1.lineWidth = 0
                dotColor.setFill()
                circle1.fill()

            } else {
                let circle = UIBezierPath(ovalIn: CGRect(x: x, y: y,
                                                         width: dotSize.width, height: dotSize.height))
                circle.lineWidth = 0
                dotColor.setFill()
                circle.fill()
            }
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    // MARK: - Interface builder

    override open func prepareForInterfaceBuilder() {
        initializeControl()
    }
}
