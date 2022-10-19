//
//  ViewController.swift
//  ShoppingListApp
//
//  Created by Seokjune Hong on 2022/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shoppingCollectionView: UICollectionView!
    @IBOutlet weak var shoppingSearchbar: UISearchBar!
    
    var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingCollectionView.collectionViewLayout = createLayout()
        shoppingCollectionView.delegate = self
        shoppingSearchbar.delegate = self
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UISearchBarDelegate {
    
}


extension ViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}
