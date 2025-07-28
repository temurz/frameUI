//
//  ProfileMediaPagesCarousel.swift
//  Tedr
//
//  Created by Kostya Lee on 18/07/25.
//

import UIKit

protocol ProfileMediaPagesCarouselDelegate: AnyObject {
    func profileMediaPagesCarousel(_ cell: ProfileMediaPagesCarousel, didScrollToPage index: Int)
}

final class ProfileMediaPagesCarousel: UICollectionViewCell {
    static let reuseIdentifier = "ProfileMediaPagesCarousel"
    
    private var collectionView: UICollectionView!
    private var pages: [ProfileMediaPage] = []
    
    weak var delegate: ProfileMediaPagesCarouselDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)

        collectionView.frame = contentView.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(ProfilePhotosPageCell.self,
                                forCellWithReuseIdentifier: ProfilePhotosPageCell.reuseIdentifier)
        collectionView.register(ProfileFilesPageCell.self,
                                forCellWithReuseIdentifier: ProfileFilesPageCell.reuseIdentifier)
        collectionView.register(ProfileLinksPageCell.self,
                                forCellWithReuseIdentifier: ProfileLinksPageCell.reuseIdentifier)
        collectionView.register(ProfileVoicePageCell.self,
                                forCellWithReuseIdentifier: ProfileVoicePageCell.reuseIdentifier)
        collectionView.register(ProfileMusicPageCell.self,
                                forCellWithReuseIdentifier: ProfileMusicPageCell.reuseIdentifier)
    }
    
    func configure(with pages: [ProfileMediaPage]) {
        self.pages = pages
        collectionView.reloadData()
    }
    
    func scrollToPage(_ index: Int, animated: Bool) {
        guard index >= 0, index < pages.count else { return }
        
        collectionView.layoutIfNeeded()
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: animated)
    }
}

extension ProfileMediaPagesCarousel: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Рассчитываем текущую стр после ручного свайпа
        let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        guard page >= 0, page < pages.count else { return }
        delegate?.profileMediaPagesCarousel(self, didScrollToPage: page)
    }
}

extension ProfileMediaPagesCarousel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let page = pages[indexPath.item]
        
        switch page.type {
        case .photosOrVideos:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfilePhotosPageCell.reuseIdentifier,
                for: indexPath
            ) as! ProfilePhotosPageCell
            cell.configure(with: page.sections)
            return cell
            
        case .files:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileFilesPageCell.reuseIdentifier,
                for: indexPath
            ) as! ProfileFilesPageCell
            cell.configure(with: page.sections)
            return cell
            
        case .links:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileLinksPageCell.reuseIdentifier,
                for: indexPath
            ) as! ProfileLinksPageCell
            cell.configure(with: page.sections)
            return cell
            
        case .voice:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileVoicePageCell.reuseIdentifier,
                for: indexPath
            ) as! ProfileVoicePageCell
            cell.configure(with: page.sections)
            return cell
            
        case .music:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileMusicPageCell.reuseIdentifier,
                for: indexPath
            ) as! ProfileMusicPageCell
            cell.configure(with: page.sections)
            return cell
        }
    }
}

extension ProfileMediaPagesCarousel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
