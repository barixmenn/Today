//
//  ReminderListViewController.swift
//  Today
//
//  Created by Baris on 31.07.2023.
//

import UIKit

private let reuseIdentifier = "Cell"
typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>


class ReminderListViewController: UICollectionViewController {
    
    //MARK: - Properties
    var dataSource : DataSource!
    var reminders: [Reminder] = Reminder.sampleData
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateSnapshot()
        
    }
    
    //MARK: - Functions
    
    private func setup() {
        configureCollection()
        
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func configureCollection() {
        let listLayout = listLayout()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        collectionView.collectionViewLayout = listLayout
        collectionView.dataSource = dataSource
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
 
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map { $0.id })
        dataSource.apply(snapshot)
    }
    
    
    
    
}

// MARK: UICollectionViewDelegate
extension ReminderListViewController {
    
}
