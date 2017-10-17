//
//  UIViewXibUtilities.swift
//
//  Created by Nikola Ristic on 11/24/16.
//  Copyright © 2016 nr. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    // MARK: - Initialize from xib

    func xibSetup() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
         // swiftlint:disable:next force_cast
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
}
