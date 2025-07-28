//
//  ProfileLinksPageCell.swift
//  Tedr
//
//  Created by Kostya Lee on 18/07/25.
//

import UIKit

final class ProfileLinksPageCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileLinksPageCell"
    
    private var collectionView: UICollectionView!
    private var sections: [ProfileMediaSection] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            // Вертикальный список ссылок
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(ProfileLinkItemCell.getDefaultHeight())
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(ProfileLinkItemCell.getDefaultHeight())
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
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
        collectionView.register(ProfileLinkItemCell.self,
                                forCellWithReuseIdentifier: ProfileLinkItemCell.reuseIdentifier)
        collectionView.register(ProfileDateHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileDateHeaderView.reuseIdentifier)
    }
    
    func configure(with sections: [ProfileMediaSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
}

extension ProfileLinksPageCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileLinkItemCell.reuseIdentifier,
                                                      for: indexPath) as! ProfileLinkItemCell
        
        if case let .text(textContent) = sections[indexPath.section].items[indexPath.item] {
            // Находим первую ссылку в attachments (если есть)
            if let linkAttachment = textContent.attachments.first(where: {
                if case .link = $0.type { return true }
                return false
            }) {
                if case let .link(url) = linkAttachment.type {
                    cell.configure(title: textContent.text)
                }
            }
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
