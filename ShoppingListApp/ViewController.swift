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
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingCollectionView.collectionViewLayout = createLayout()
        shoppingCollectionView.delegate = self
        shoppingSearchbar.delegate = self
        
        configureDataSource()
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
    
    private func configureDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.secondaryText = "\(itemIdentifier.count)"
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.backgroundColor = .lightGray
            cell.backgroundConfiguration = background
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: shoppingCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
}
