//
//  ChatMessageRow.swift
//  Tedr
//
//  Created by Kostya Lee on 11/06/25.
//

import Foundation

// ChatMessageRow для отображения на фронте. Далее будет какой нибудь ChatEntity для работы с сетью и мапперы

struct ChatMessageRow {
    let id: String
    let senderId: String
    let date: Date
    let isIncoming: Bool
    let content: MessageContent
    let replyTo: ReplyInfo?
}

enum MessageContent {
    case text(TextContent)
    case media(MediaContent)
    case voice(VoiceContent)
    case file(FileContent)
    case location(LocationContent)
    case contact(ContactContent)
    case transaction(TransactionContent)
}

struct TextContent {
    let text: String
    let attachments: [Attachment] // ссылки, упоминания, т.д.
}

struct MediaContent {
    let text: String? // подпись под фото
    let imageUrls: [URL]
}

struct VoiceContent {
    let url: URL
    let duration: TimeInterval
}

struct FileContent {
    let url: URL
    let fileName: String
}

struct LocationContent {
    let latitude: Double
    let longitude: Double
}

struct ContactContent {
    let name: String
    let phone: String
}

struct TransactionContent {
    let amount: Double                  // Сумма
    let currency: String                // Валюта (например, "USD")
    let coinImageName: String           // Название иконки в Assets (например, "ustt_icon_colored")
    let token: String                   // Тип крипты (например, "ETH")
    let isLocked: Bool                  // Заблокировано или разблокировано
    let statusText: String?             // Completed / Failed / In progress / Tap to unlock
    let unlockTimeLeft: TimeInterval?   // Таймер (в секундах)
}

struct Attachment {
    enum AttachmentType {
        case link(URL)                     // Ссылки
        case mention(userId: String, username: String) // Упоминания ботов, людей
        case hashtag(String)               // Хэштеги
        case command(String)               // Команды для ботов: /start, /help
        case phoneNumber(String)
        case email(String)
    }

    let type: AttachmentType
    let range: NSRange // Позиция в тексте для подсветки
}

struct ReplyInfo {
    let messageId: String
    let senderName: String
    let previewContent: ReplyContent
}

enum ReplyContent {
    case text(String)
    case image(URL)
    case voice(URL)
    case file(String)
    case transaction(amount: Double, currency: String)
    case location
    case contact(name: String)
}
