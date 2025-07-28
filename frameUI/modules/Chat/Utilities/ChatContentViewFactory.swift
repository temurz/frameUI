//
//  ChatContentViewFactory.swift
//  Tedr
//
//  Created by Kostya Lee on 27/06/25.
//

import Foundation
import UIKit
final class ChatContentViewFactory {
    static func view(for message: ChatMessageRow) -> UIView {
        switch message.content {
        case .text(let textContent):
            let view = ChatMessageTextView()
            view.configure(message: message, content: textContent)
            return view
        case .transaction(let tx):
            let view = ChatMessageTransactionView()
            view.configure(with: tx, timeText: ChatDataManager.formatTimeForChat(message.date))
            return view
        default:
            let view = ChatMessageTextView()
            view.configure(message: message, content: TextContent(text: "Unsupported message", attachments: []))
            return view
        }
    }
}
