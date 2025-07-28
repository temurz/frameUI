//
//  ProfilePhotosPageCell.swift
//  Tedr
//
//  Created by Kostya Lee on 18/07/25.
//

import UIKit

final class ProfilePhotosPageCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileMediaPageCell"
    
    private var collectionView: UICollectionView!
    private var sections: [ProfileMediaSection] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            let section = self.sections[sectionIndex]
            
            // Элементы 3x3
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalWidth(1/3)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(120)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            let layoutSection = NSCollectionLayoutSection(group: group)
            
            // Хедер с датой
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(32)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            layoutSection.boundarySupplementaryItems = [header]
            
            return layoutSection
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false // MARK: Here <-
        contentView.addSubview(collectionView)
        
        collectionView.frame = contentView.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MediaCell")
        collectionView.register(ProfileDateHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileDateHeaderView.reuseIdentifier)
    }
    
    func configure(with sections: [ProfileMediaSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
}

extension ProfilePhotosPageCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath)
        let content = sections[indexPath.section].items[indexPath.item]
        switch content {
        case .media(let image):
            cell.backgroundColor = .blue
        default: break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProfileDateHeaderView.reuseIdentifier,
                for: indexPath
            ) as! ProfileDateHeaderView
            header.configure(with: sections[indexPath.section].date)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
