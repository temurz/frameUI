//
//  ProfileAvatarView.swift
//  Tedr
//
//  Created by Kostya Lee on 09/07/25.
//

import Foundation
import UIKit
final class ProfileAvatarView: UICollectionViewCell {
    static let reuseIdentifier = "ProfileAvatarView"
    
    private var avatarCollectionView: UICollectionView?
    private var pageControl: ProfilePageControlView!

    private let images = ["user1", "user2", "user3", "user4"]
    
    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    
//    private var searchGlassView: UIVisualEffectView?
    private var searchButton: UIButton?
    
//    private var callGlassView: UIVisualEffectView?
    private var callButton: UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let theme = Theme()
        
        // Collection View
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = bounds.size

        avatarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        avatarCollectionView?.isPagingEnabled = true
        avatarCollectionView?.showsHorizontalScrollIndicator = false
        avatarCollectionView?.dataSource = self
        avatarCollectionView?.delegate = self
        avatarCollectionView?.register(AvatarImageCell.self, forCellWithReuseIdentifier: AvatarImageCell.identifier)
        avatarCollectionView?.backgroundColor = .clear
        addSubview(avatarCollectionView)
        
        addGradientBlur()
        
        // Page Control
        pageControl = ProfilePageControlView()
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        addSubview(pageControl)
        
        // Labels
        titleLabel = UILabel()
        titleLabel?.text = "Jane Smith"
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = theme.contentWhite
        titleLabel?.font = theme.getFont(size: 24, weight: .semibold)
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel?.text = "@jane"
        subtitleLabel?.textAlignment = .center
        subtitleLabel?.textColor = theme.contentWhite
        subtitleLabel?.font = theme.getFont(size: 18, weight: .regular)
        self.addSubview(subtitleLabel)
        
        searchButton = UIButton()
        searchButton?.setImage(theme.searchIcon, for: .normal)
        searchButton?.backgroundColor = theme.contentWhite.withAlphaComponent(0.2)
        self.addSubview(searchButton)
        
        callButton = UIButton()
        callButton?.setImage(theme.telephoneIcon, for: .normal)
        callButton?.backgroundColor = theme.contentWhite.withAlphaComponent(0.2)
        self.addSubview(callButton)
    }
    
    private func addGradientBlur() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.frame = self.bounds
        
        let gradient = CAGradientLayer()
        gradient.frame = blurView.bounds
        gradient.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        gradient.locations = [0.0, 0.3]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0) // снизу
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)   // вверх

        blurView.layer.mask = gradient
        
        self.addSubview(blurView)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let padding: CGFloat = 16
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0
        
        self.avatarCollectionView?.frame = bounds

        let pageControlHeight: CGFloat = 4
        x = padding
        y = bounds.height - pageControlHeight - 12
        w = bounds.width - x*2
        h = pageControlHeight
        self.pageControl.frame = CGRect(x: x, y: y, width: w, height: h)

        if let layout = avatarCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = bounds.size
        }
        
        x = padding
        w = subtitleLabel!.getWidth()
        h = 18
        y = pageControl.minY - h - 14
        self.subtitleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = titleLabel!.getWidth()
        h = 24
        y -= h + 6
        self.titleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = 48
        h = w
        x = bounds.width - w - padding
        y = subtitleLabel!.maxY - h
//        self.callGlassView?.frame = CGRect(x: x, y: y, width: w, height: h)
        self.callButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        callButton?.layer.cornerRadius = h/2
        
        x = callButton!.minX - w - padding
//        self.searchGlassView?.frame = CGRect(x: x, y: y, width: w, height: h)
        self.searchButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        searchButton?.layer.cornerRadius = h/2

    }
}

extension ProfileAvatarView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarImageCell.identifier, for: indexPath) as? AvatarImageCell else {
            return UICollectionViewCell()
        }

        cell.setImage(UIImage(named: images[indexPath.item]))
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        pageControl.currentPage = page
    }
}

final class AvatarImageCell: UICollectionViewCell {
    static let identifier = "AvatarImageCell"

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
}
