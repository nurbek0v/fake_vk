//
//  String + Height.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 11.11.2022.
//

import Foundation
import UIKit


extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: textSize,
                                   options: .usesLineFragmentOrigin,
                                   attributes: [NSAttributedString.Key.font : font],
                                   context: nil)
        return ceil(size.height)
    }
}
