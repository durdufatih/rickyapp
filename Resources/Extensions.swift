//
//  Extensions.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 30.12.2022.
//

import UIKit

extension UIView{
    func addSubviews(_ views:UIView...){
        views.forEach ({
            addSubview($0)
        })
    }
}
