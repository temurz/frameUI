//
//  ProfileVoicePageCell.swift
//  Tedr
//
//  Created by Kostya Lee on 18/07/25.
//

import UIKit

final class ProfileVoicePageCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileVoicePageCell"
    
    private var collectionView: UICollectionView!
    private var sections: [ProfileMediaSection] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            // Вертикальный список голосовых сообщений
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(ProfileVoiceItemCell.getHeight())
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(ProfileVoiceItemCell.getHeight())
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
        collectionView.register(ProfileVoiceItemCell.self,
                                forCellWithReuseIdentifier: ProfileVoiceItemCell.reuseIdentifier)
        collectionView.register(ProfileDateHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileDateHeaderView.reuseIdentifier)
    }
    
    func configure(with sections: [ProfileMediaSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
}

extension ProfileVoicePageCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileVoiceItemCell.reuseIdentifier,
                                                      for: indexPath) as! ProfileVoiceItemCell
        
        if case let .voice(voiceContent) = sections[indexPath.section].items[indexPath.item] {
            let duration = formatDuration(voiceContent.duration)
            cell.configure(title: "Голосовое сообщение", duration: duration, date: sections[indexPath.section].date)
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
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
