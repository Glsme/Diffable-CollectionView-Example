//
//  ViewController.swift
//  ShoppingListApp
//
//  Created by Seokjune Hong on 2022/10/20.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var shoppingCollectionView: UICollectionView!
    @IBOutlet weak var shoppingSearchbar: UISearchBar!
    
    var list: [ShoppingListModel] = [ShoppingListModel(title: "에어팟")]
    
    let viewModel = ViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, ShoppingListModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingCollectionView.collectionViewLayout = createLayout()
        shoppingCollectionView.delegate = self
        shoppingSearchbar.delegate = self
        
        configureDataSource()
    }
    
    func bind() {
        
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var snapshot = dataSource.snapshot()
        
        guard let text = searchBar.text else { return }
        snapshot.appendItems([ShoppingListModel(title: text)], toSection: 1)
        dataSource.apply(snapshot, animatingDifferences: true)
        searchBar.text = nil
    }
}


extension ViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, ShoppingListModel> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.title.count)"
            cell.contentConfiguration = content
            
            let background = UIBackgroundConfiguration.listPlainCell()
            cell.backgroundConfiguration = background
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: shoppingCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, ShoppingListModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(list, toSection: 0)
        dataSource.apply(snapshot)
    }
}
