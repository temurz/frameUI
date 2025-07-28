//
//  ChatDataManager.swift
//  Tedr
//
//  Created by Kostya Lee on 28/06/25.
//

import Foundation
final class ChatDataManager {
    static func formatTimeForChat(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
}
