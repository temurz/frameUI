//
//  ChatInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 11/06/25.
//

import Foundation
final class ChatInteractor: PresenterToInteractorChatProtocol {
    weak var presenter: InteractorToPresenterChatProtocol?

    func fetchMessages() {
        let mockMessages: [ChatMessageRow] = [
            ChatMessageRow(
                id: "13",
                senderId: "user1",
                date: Date(),
                isIncoming: true,
                content: .transaction(TransactionContent(
                    amount: 50.00,
                    currency: "USD",
                    coinImageName: "ustt_icon_colored",
                    token: "ETH",
                    isLocked: false,
                    statusText: "Completed",
                    unlockTimeLeft: nil
                )),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "14",
                senderId: "me",
                date: Date(),
                isIncoming: false,
                content: .transaction(TransactionContent(
                    amount: 1299.15,
                    currency: "USD",
                    coinImageName: "ustt_icon_colored",
                    token: "ETH",
                    isLocked: true,
                    statusText: "Tap to unlock",
                    unlockTimeLeft: 12000
                )),
                replyTo: nil
            ),
            ChatMessageRow(
                id: "15",
                senderId: "user1",
                date: Date(),
                isIncoming: true,
                content: .transaction(TransactionContent(
                    amount: 320.00,
                    currency: "USD",
                    coinImageName: "ustt_icon_colored",
                    token: "BTC",
                    isLocked: false,
                    statusText: "Failed",
                    unlockTimeLeft: nil
                )),
                replyTo: nil
            ),
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
                content: .text(TextContent(text: "Вот одна — закат над вершинами 🌄", attachments: [])),
                replyTo: nil
            )
        ]
        
        presenter?.didFetchMessages(mockMessages)
    }
}
