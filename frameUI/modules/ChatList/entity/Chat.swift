//
//  Chat.swift
//  Tedr
//
//  Created by Kostya Lee on 03/06/25.
//

import Foundation

struct Chat {
    let id: String
    let title: String
    var username: String?
    let lastMessage: String?
    let lastMessageDate: Date?
    let unreadCount: Int
    let isMuted: Bool
    let avatarURL: URL?
    
    var isPinned: Bool = false
}
