//
//  UserProfileStoriesView.swift
//  Tedr
//
//  Created by Kostya Lee on 11/07/25.
//

import Foundation
import UIKit
final class ProfileStoriesView: UICollectionViewCell {
    
    static let reuseIdentifier = "ProfileStoriesView"
    private var storiesView: UICollectionView?
    
    private var stories = [Story]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        layout.itemSize = ChatListStoryCell.getSize()
        
        storiesView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        storiesView?.showsHorizontalScrollIndicator = false
        storiesView?.backgroundColor = .clear
        storiesView?.register(ChatListStoryCell.self, forCellWithReuseIdentifier: ChatListStoryCell.reuseId)
        
        storiesView?.delegate = self
        storiesView?.dataSource = self
        
        addSubview(storiesView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let h: CGFloat = ChatListStoryCell.getSize().height
        let w: CGFloat = bounds.width
        storiesView?.frame = CGRect(x: 0, y: 0, width: w, height: h)
    }
    
    func getHeight() -> CGFloat {
        return ChatListStoryCell.getSize().height
    }
    
    func setStories(_ stories: [Story]) {
        self.stories = stories
        storiesView?.reloadData()
    }
}

extension ProfileStoriesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatListStoryCell.reuseId, for: indexPath) as? ChatListStoryCell else { return UICollectionViewCell() }
        cell.configure(item: self.stories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
