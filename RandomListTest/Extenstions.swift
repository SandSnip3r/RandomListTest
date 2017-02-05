//
//  Extenstions.swift
//  RandomListTest
//
//  Created by Victor Stone on 2/4/17.
//  Copyright © 2017 Victor Stone. All rights reserved.
//

import UIKit

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
