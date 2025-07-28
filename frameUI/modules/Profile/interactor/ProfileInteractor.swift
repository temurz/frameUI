//
//  UserProfileInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 11/07/25.
//

import Foundation
final class ProfileInteractor {
    static func fetchStories() -> [Story] {
        return [
            Story(
                id: "s1",
                userName: "My story",
                userAvatarURL: URL(string: "https://randomuser.me/api/portraits/women/99.jpg"),
                previewImageURL: URL(string: "https://source.unsplash.com/random/100x100?selfie")!,
                isSeen: false,
                isMyStory: true,
                timestamp: Date()
            ),
            Story(
                id: "s2",
                userName: "Johnny",
                userAvatarURL: URL(string: "https://randomuser.me/api/portraits/men/1.jpg"),
                previewImageURL: URL(string: "https://source.unsplash.com/random/100x100?sunset")!,
                isSeen: false,
                isMyStory: false,
                timestamp: Date().addingTimeInterval(-3600)
            ),
            Story(
                id: "s3",
                userName: "Alexandra",
                userAvatarURL: URL(string: "https://randomuser.me/api/portraits/women/1.jpg"),
                previewImageURL: URL(string: "https://source.unsplash.com/random/100x100?beach")!,
                isSeen: true,
                isMyStory: false,
                timestamp: Date().addingTimeInterval(-7200)
            ),
            Story(
                id: "s4",
                userName: "Paul Anderson",
                userAvatarURL: URL(string: "https://randomuser.me/api/portraits/men/2.jpg"),
                previewImageURL: URL(string: "https://source.unsplash.com/random/100x100?mountains")!,
                isSeen: false,
                isMyStory: false,
                timestamp: Date().addingTimeInterval(-5400)
            ),
            Story(
                id: "s5",
                userName: "Emma",
                userAvatarURL: URL(string: "https://randomuser.me/api/portraits/women/2.jpg"),
                previewImageURL: URL(string: "https://source.unsplash.com/random/100x100?city")!,
                isSeen: true,
                isMyStory: false,
                timestamp: Date().addingTimeInterval(-10800)
            ),
            Story(
                id: "s6",
                userName: "Tom",
                userAvatarURL: URL(string: "https://randomuser.me/api/portraits/men/18.jpg"),
                previewImageURL: URL(string: "https://source.unsplash.com/random/100x100?city")!,
                isSeen: true,
                isMyStory: false,
                timestamp: Date().addingTimeInterval(-10800)
            )
        ]
    }
}
