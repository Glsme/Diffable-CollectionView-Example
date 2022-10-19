//
//  shoppingListModel.swift
//  ShoppingListApp
//
//  Created by Seokjune Hong on 2022/10/20.
//

import Foundation

struct ShoppingListModel: Hashable {
    let id = UUID().uuidString
    let title: String
}
