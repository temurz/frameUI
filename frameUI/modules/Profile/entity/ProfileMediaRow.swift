//
//  ProfileMediaRow.swift
//  Tedr
//
//  Created by Kostya Lee on 18/07/25.
//

import Foundation
import UIKit

// Тип медиа для страниц (отражает вкладки в mediaTypePicker)
enum ProfileMediaType: CaseIterable {
    case photosOrVideos
    case files
    case links
    case voice
    case music
}

// Страница медиа-контента (каждая страница — отдельный тип медиа)
struct ProfileMediaPage {
    let type: ProfileMediaType
    let sections: [ProfileMediaSection]
}

// Секция медиа внутри страницы (например: "Сегодня", "Вчера")
struct ProfileMediaSection {
    let date: String
    let items: [MessageContent] // теперь используем ChatMessageRow.MessageContent
}

// Конкретный элемент медиа (фото, видео и т.д.)
struct ProfileMediaRow {
    let id: String
    let image: UIColor // в реальности тут будет URL, пока mock цвет
    let date: String
}
