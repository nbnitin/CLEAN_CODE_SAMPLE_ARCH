//
//  UIViewExtension.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/8/21.
//

import UIKit

extension UIView {
    func showActivityIndicator() -> UIActivityIndicatorView {
        if let act = self.viewWithTag(980) as? UIActivityIndicatorView {
            act.removeFromSuperview()
        }
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(actInd)
        actInd.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        actInd.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        actInd.hidesWhenStopped = true
        actInd.style = .large
        actInd.startAnimating()
        actInd.tag = 980
        return actInd
    }
}
