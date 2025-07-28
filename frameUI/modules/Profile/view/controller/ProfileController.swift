//
//  UserProfileController.swift
//  Tedr
//
//  Created by Kostya Lee on 08/07/25.
//

import Foundation
import UIKit

enum ProfileSection {
    case avatar
    case stories(items: [Story])
    case contact
    case mediaPages(items: [ProfileMediaPage])
}

final class ProfileController: TemplateController {
    private var collectionView: UICollectionView!
    private let navBar = ProfileNavigationBar()
    private let mediaTypePicker = ProfileMediaTypePicker()

    private var stories: [Story] = []
    private var sections: [ProfileSection] = []
    
    // Источник правды для всех типов медиа
    private var allMediaPages: [ProfileMediaPage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeMockData()
        initialize()
    }
    
    override func initialize() {
        view.backgroundColor = Theme().backgroundPrimaryColor
        setupCollectionView()
        
        // Picker
        mediaTypePicker.onItemSelected = { [weak self] index in
            guard let self = self else { return }
            let mediaPagesIndex = 3 // 0: avatar, 1: stories, 2: contact, 3: mediaPages
            let indexPath = IndexPath(item: 0, section: mediaPagesIndex)
            
            if let cell = self.collectionView.cellForItem(at: indexPath) as? ProfileMediaPagesCarousel {
                cell.scrollToPage(index, animated: true)
            }
        }
        view.addSubview(mediaTypePicker)
        mediaTypePicker.frame = CGRect(
            x: 0,
            y: getMediaPickerTypeInitialY(),
            width: view.bounds.width,
            height: mediaTypePicker.getHeight()
        )
        
        view.addSubview(navBar)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        let x = CGFloat(0)
        var y = CGFloat(0)
        let w = CGFloat(size.width)
        var h = CGFloat(size.height)
        
        collectionView.frame = CGRect(x: x, y: y, width: w, height: h)
        collectionView.contentInset.top = -(topSafe ?? 0)
        
        y = 0
        h = navBar.getHeight()
        navBar.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    private func setupCollectionView() {
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(ProfileAvatarView.self, forCellWithReuseIdentifier: ProfileAvatarView.reuseIdentifier)
        collectionView.register(ProfileStoriesView.self, forCellWithReuseIdentifier: ProfileStoriesView.reuseIdentifier)
        collectionView.register(ProfileContactView.self, forCellWithReuseIdentifier: ProfileContactView.reuseIdentifier)
        collectionView.register(ProfileMediaPagesCarousel.self, forCellWithReuseIdentifier: ProfileMediaPagesCarousel.reuseIdentifier)
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let sectionType = self.sections[sectionIndex]
            
            switch sectionType {
            case .avatar:
                let size = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: size)
                return NSCollectionLayoutSection(group: .vertical(layoutSize: size, subitems: [item]))
                
            case .stories:
                let cellSize = ChatListStoryCell.getSize()
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(self.view.bounds.width),
                    heightDimension: .estimated(cellSize.height)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: itemSize,
                    subitems: [NSCollectionLayoutItem(layoutSize: itemSize)]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 12
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
                return section
                
            case .contact:
                let size = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(ProfileContactView.getHeight())
                )
                let item = NSCollectionLayoutItem(layoutSize: size)
                return NSCollectionLayoutSection(group: .vertical(layoutSize: size, subitems: [item]))
                
            case .mediaPages:
                let size = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(800)
                    // В будующем тут нужно будет обновлять для пагинации
                )
                let item = NSCollectionLayoutItem(layoutSize: size)
                return NSCollectionLayoutSection(group: .vertical(layoutSize: size, subitems: [item]))
            }
        }
    }
}

extension ProfileController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .avatar, .stories, .contact:
            return 1
        case .mediaPages:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .avatar:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileAvatarView.reuseIdentifier,
                for: indexPath
            )
            
        case .stories(let items):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileStoriesView.reuseIdentifier,
                for: indexPath
            ) as! ProfileStoriesView
            cell.setStories(items)
            return cell
            
        case .contact:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileContactView.reuseIdentifier,
                for: indexPath
            )
            
        case .mediaPages(let pages):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileMediaPagesCarousel.reuseIdentifier,
                for: indexPath
            ) as? ProfileMediaPagesCarousel else { return UICollectionViewCell() }
            cell.configure(with: pages)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: Mock data
extension ProfileController {
    // В будующем здесь будет мапиться items из сети и распределяться
    private func makeMockData() {
        allMediaPages = [
            ProfileMediaPage(
                type: .photosOrVideos,
                sections: [
                    ProfileMediaSection(date: "Сегодня", items: generatePhotoItems(count: 9)),
                    ProfileMediaSection(date: "Вчера", items: generatePhotoItems(count: 6))
                ]
            ),
            ProfileMediaPage(
                type: .files,
                sections: [
                    ProfileMediaSection(date: "10 июля", items: generateFileItems(count: 4))
                ]
            ),
            ProfileMediaPage(
                type: .voice,
                sections: [
                    ProfileMediaSection(date: "1 июля", items: generateVoiceItems(count: 5))
                ]
            ),
            ProfileMediaPage(
                type: .music,
                sections: [
                    ProfileMediaSection(date: "27 июня", items: generateMusicItems(count: 4))
                ]
            ),
            ProfileMediaPage(
                type: .links,
                sections: [
                    ProfileMediaSection(date: "3 июля", items: generateLinkItems(count: 3))
                ]
            )
        ]
        
        sections = [
            .avatar,
            .stories(items: ProfileInteractor.fetchStories()),
            .contact,
            .mediaPages(items: allMediaPages)
        ]
    }

    // MARK: - Генерация контента для моков
    private func generatePhotoItems(count: Int) -> [MessageContent] {
        return (0..<count).map { _ in
            .media(MediaContent(text: "Красивое фото", imageUrls: [URL(string: "https://example.com/photo.jpg")!]))
        }
    }

    private func generateFileItems(count: Int) -> [MessageContent] {
        return (0..<count).map { index in
            .file(FileContent(url: URL(string: "https://example.com/file\(index).pdf")!,
                              fileName: "Документ \(index + 1)"))
        }
    }

    private func generateLinkItems(count: Int) -> [MessageContent] {
        return (0..<count).map { index in
            let linkURL = URL(string: "https://example.com/article\(index)")!
            let attachment = Attachment(type: .link(linkURL),
                                        range: NSRange(location: 0, length: 10))
            return .text(TextContent(text: "Интересная статья \(index + 1)", attachments: [attachment]))
        }
    }

    private func generateVoiceItems(count: Int) -> [MessageContent] {
        return (0..<count).map { index in
            .voice(VoiceContent(url: URL(string: "https://example.com/voice\(index).m4a")!,
                                duration: TimeInterval(30 + index * 15)))
        }
    }

    private func generateMusicItems(count: Int) -> [MessageContent] {
        return (0..<count).map { index in
            // В реальном случае будет MusicContent, но пока используем FileContent
            .file(FileContent(url: URL(string: "https://example.com/music\(index).mp3")!,
                              fileName: "Трек \(index + 1)"))
        }
    }
}

extension ProfileController: ProfileMediaPagesCarouselDelegate {
    func profileMediaPagesCarousel(_ cell: ProfileMediaPagesCarousel, didScrollToPage index: Int) {
        mediaTypePicker.setSelectedIndex(index) // обновляем UI picker’а
    }
}

extension ProfileController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateMediaTypePickerY(scrollView.contentOffset.y)
        navBar.updateOffsetChanged(scrollView.contentOffset.y)
    }
    
    private func getMediaPickerTypeInitialY() -> CGFloat {
        let avatarH: CGFloat = view.bounds.width
        let storiesH: CGFloat = ChatListStoryCell.getSize().height
        let contactH: CGFloat = ProfileContactView.getHeight()
        return avatarH + storiesH + contactH
    }
    
    func updateMediaTypePickerY(_ offsetY: CGFloat) {
        let minY = navBar.frame.maxY
        let mediaInitialY: CGFloat = getMediaPickerTypeInitialY()
        let targetY = max(minY, mediaInitialY - offsetY)

        mediaTypePicker.frame.origin.y = targetY
    }
}
