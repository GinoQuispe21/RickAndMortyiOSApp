//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 2/09/23.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
    
}
