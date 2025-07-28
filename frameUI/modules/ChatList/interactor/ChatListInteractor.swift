//
//  ChatListInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 03/06/25.
//

import Foundation
final class ChatListInteractor: PresenterToInteractorChatListProtocol {
    weak var presenter: InteractorToPresenterChatListProtocol?
    
    let mockChats: [Chat] = [
        Chat(id: "1", title: "Saved messages", username: "@johny", lastMessage: "Tezro.pdf", lastMessageDate: Date(), unreadCount: 0, isMuted: false, avatarURL: nil, isPinned: true),
        Chat(id: "2", title: "Paul Anderson", username: "@vanessa", lastMessage: "typing...", lastMessageDate: Date(), unreadCount: 2, isMuted: true, avatarURL: URL(string: "https://randomuser.me/api/portraits/men/1.jpg"), isPinned: true),
        Chat(id: "3", title: "Alice", username: "@alice", lastMessage: "Hey, how are you?", lastMessageDate: Date(), unreadCount: 1, isMuted: false, avatarURL: URL(string: "https://randomuser.me/api/portraits/women/1.jpg")),
        Chat(id: "4", title: "Bob", username: "@bob", lastMessage: "Meeting at 5", lastMessageDate: Date(), unreadCount: 0, isMuted: false, avatarURL: URL(string: "https://randomuser.me/api/portraits/men/2.jpg")),
        Chat(id: "5", title: "Team", lastMessage: "Updated doc", lastMessageDate: Date(), unreadCount: 3, isMuted: true, avatarURL: nil),
        Chat(id: "6", title: "Mom", lastMessage: "Dinner?", lastMessageDate: Date(), unreadCount: 0, isMuted: false, avatarURL: URL(string: "https://randomuser.me/api/portraits/women/2.jpg")),
        Chat(id: "7", title: "Dad", lastMessage: "Check this out", lastMessageDate: Date(), unreadCount: 4, isMuted: false, avatarURL: URL(string: "https://randomuser.me/api/portraits/men/3.jpg")),
        Chat(id: "8", title: "Manager", lastMessage: "Task for today", lastMessageDate: Date(), unreadCount: 0, isMuted: true, avatarURL: URL(string: "https://randomuser.me/api/portraits/men/4.jpg")),
        Chat(id: "9", title: "Designer", lastMessage: "Updated banner", lastMessageDate: Date(), unreadCount: 0, isMuted: false, avatarURL: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")),
        Chat(id: "10", title: "HR", lastMessage: "Contract", lastMessageDate: Date(), unreadCount: 0, isMuted: false, avatarURL: URL(string: "https://randomuser.me/api/portraits/men/6.jpg"))
    ]
    
    func fetchChats() {
        presenter?.didFetchChats(mockChats)
    }

    func fetchSearchResult(_ text: String) {
        var result: [SearchResultSection: [ChatSearchResult]] = [:]
        if text.isEmpty {
            result[.recent] = mockChats.prefix(3).map({ ChatSearchResult(id: $0.id, name: $0.title, subtitle: $0.username, imageUrl: $0.avatarURL) })
            presenter?.didFetchSearchResult(result)
            return
        }
        result[.chats] = mockChats
            .filter { $0.title.contains(text) }
            .map({ ChatSearchResult(id: $0.id, name: $0.title, subtitle: $0.username, imageUrl: $0.avatarURL)
        })
        presenter?.didFetchSearchResult(result)
    }
    
    func fetchStories() {
        let mockStories: [Story] = [
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

        presenter?.didFetchStories(mockStories)
    }

    func fetchAppConfig() {
//        let config = AppConfig() // Загрузить конфиг (например, фичи, флаги)
        presenter?.didFetchAppConfig("some config")
    }
    
    func fetchMessages(for chat: Chat) {
        let mockMessages: [ChatMessageRow] = [
            ChatMessageRow(
                id: "1",
                senderId: "user1",
                date: Date(),
                isIncoming: true,
                content: .text(TextContent(text: "Привет!", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "2",
                senderId: "me",
                date: Date(),
                isIncoming: false,
                content: .text(TextContent(text: "Хей, как дела?", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "3",
                senderId: "me",
                date: Date(),
                isIncoming: false,
                content: .text(TextContent(text: "I wanna go to the mountains. But I'm short on funds 🤨 Give me money!", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "4",
                senderId: "user1",
                date: Date(),
                isIncoming: true,
                content: .text(TextContent(text: "😂😂😂", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "5",
                senderId: "user1",
                date: Date(),
                isIncoming: true,
                content: .text(TextContent(text: "В пятницу собираемся на кофе, ты с нами?", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "6",
                senderId: "me",
                date: Date(),
                isIncoming: false,
                content: .text(TextContent(text: "Да, давай! Где встречаемся?", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "7",
                senderId: "user1",
                date: Date(),
                isIncoming: true,
                content: .text(TextContent(text: "Тот же Spazio на Ташкентской в 18:00", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "8",
                senderId: "me",
                date: Date(),
                isIncoming: false,
                content: .text(TextContent(text: "Окей, буду ✌️", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "9",
                senderId: "user1",
                date: Date(),
                isIncoming: true,
                content: .text(TextContent(text: "А ты что в выходные делал?", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "10",
                senderId: "me",
                date: Date(),
                isIncoming: false,
                content: .text(TextContent(text: "Съездили в горы с ребятами. Было круто, природа, костёр, гитара, всё как надо.", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "11",
                senderId: "user1",
                date: Date(),
                isIncoming: true,
                content: .text(TextContent(text: "Звучит как мечта 😍", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "12",
                senderId: "me",
                date: Date(),
                isIncoming: false,
                content: .text(TextContent(text: "Да, отвлеклись от всего", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "13",
                senderId: "user1",
                date: Date(),
                isIncoming: true,
                content: .text(TextContent(text: "Скинь пару фоток!", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "14",
                senderId: "me",
                date: Date(),
                isIncoming: false,
                content: .text(TextContent(text: "Ща, подожди секунду...", attachments: [])),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "15",
                senderId: "me",
                date: Date(),
                isIncoming: false,
                content: .text(TextContent(text: "Вот одна — закат над вершинами 🌄", attachments: [])),
                replyTo: nil
            )
        ]

        presenter?.didFetchMessages(mockMessages)
    }
}
