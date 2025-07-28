//
//  Story.swift
//  Tedr
//
//  Created by Kostya Lee on 03/06/25.
//

import Foundation

struct Story {
    let id: String
    let userName: String
    let userAvatarURL: URL?
    let previewImageURL: URL
    let isSeen: Bool
    let isMyStory: Bool
    let timestamp: Date
}
