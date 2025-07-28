//
//  ProfileFilesPageCell.swift
//  Tedr
//
//  Created by Kostya Lee on 18/07/25.
//

import UIKit

final class ProfileFilesPageCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileFilesPageCell"
    
    private var collectionView: UICollectionView!
    private var sections: [ProfileMediaSection] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            // Вертикальный список файлов
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(ProfileFileItemCell.getHeight())
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(ProfileFileItemCell.getHeight())
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            // Date Header
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(32)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
            return section
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        contentView.addSubview(collectionView)
        
        collectionView.frame = contentView.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.dataSource = self
        collectionView.register(ProfileFileItemCell.self,
                                forCellWithReuseIdentifier: ProfileFileItemCell.reuseIdentifier)
        collectionView.register(ProfileDateHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileDateHeaderView.reuseIdentifier)
    }
    
    func configure(with sections: [ProfileMediaSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
}

extension ProfileFilesPageCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileFileItemCell.reuseIdentifier,
                                                      for: indexPath) as! ProfileFileItemCell
        if case let .file(fileContent) = sections[indexPath.section].items[indexPath.item] {
            cell.configure(fileName: fileContent.fileName, size: "2.3 MB")
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
