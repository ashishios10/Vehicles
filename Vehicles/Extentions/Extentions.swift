//
//  Extentions.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

import UIKit

extension String {
    func localized (bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
}

@objc public extension UIView {
    
    func addSubViewWithConstraint(subView: UIView,
                                  left: CGFloat,
                                  top: CGFloat,
                                  right: CGFloat,
                                  height: CGFloat) {
        self.addSubViewWithConstraint(subView: subView, leftPadding: left, rightPadding: right, topPadding: top, height: height)
    }
    
    func addSubViewWithConstraint(subView: UIView,
                                  left: CGFloat,
                                  top: CGFloat,
                                  width: CGFloat,
                                  height: CGFloat) {
        self.addSubViewWithConstraint(subView: subView, leftPadding: left, topPadding: top, width: width, height: height)
    }
    
    func addSubViewWithConstraint(subView: UIView,
                                  left: CGFloat,
                                  top: CGFloat,
                                  right: CGFloat,
                                  bottom: CGFloat) {
        self.addSubViewWithConstraint(subView: subView, leftPadding: left, rightPadding: right, topPadding: top, bottomPadding: bottom)
    }
    
    @nonobjc func addSubViewWithConstraint(subView: UIView, leftPadding: CGFloat, rightPadding: CGFloat? = nil, topPadding: CGFloat, bottomPadding: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftPadding).isActive = true
        subView.topAnchor.constraint(equalTo: self.topAnchor, constant: topPadding).isActive = true
        if let right = rightPadding {
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -right).isActive = true
        }
        if let bottom = bottomPadding {
            subView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottom).isActive = true
        }
        if let width = width {
            subView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            subView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// MARK: - UIViewController + AppCoordinator

@objc public extension UIViewController {
    @objc weak var appCoordinator: Coordinator? {
        return (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator
    }
}
