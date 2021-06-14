//
//  NSMutableAttributedString+BoldTitle.swift
//  Pokedex
//
//  Created by Matheus Torres on 14/06/21.
//

import UIKit

extension NSMutableAttributedString {
    public static func attributeStringWith(title: String, description: String, size: CGFloat) -> NSMutableAttributedString {
        let boldAttrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)]
        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)]
        
        let attrTitle = NSMutableAttributedString(string: title, attributes: boldAttrs)
        let attrDescription = NSMutableAttributedString(string: description, attributes: normalAttrs)
        attrTitle.append(attrDescription)
        return attrTitle
    }
}
