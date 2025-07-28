//
//  MessageProvider.swift
//  Tedr
//
//  Created by Temur on 29/06/2025.
//

import UIKit

class MessageProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var items: [ChatMessageRow]
    
    init(items: [ChatMessageRow]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.reuseId, for: indexPath) as? ChatCell else {
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row])
        cell.transform = CGAffineTransform(scaleX: 1, y: -1) 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = items[indexPath.row]
        let horizontalPadding: CGFloat = 12
        let verticalPadding: CGFloat = 6
        let timeHeight: CGFloat = 16

        let maxBubbleWidth = tableView.bounds.width * 0.85
        let timeLabelWidth: CGFloat = message.isIncoming ? 70 : 85
        let availableTextWidth = maxBubbleWidth - horizontalPadding * 2 - timeLabelWidth

        let font = Theme().getFont(size: 16, weight: .regular)
        let constraintBox = CGSize(width: availableTextWidth, height: .greatestFiniteMagnitude)
        var textToMeasure = ""

        if case let .text(textContent) = message.content {
            textToMeasure = textContent.text
        }

        let boundingBox = textToMeasure.boundingRect(
            with: constraintBox,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )

        return boundingBox.height + verticalPadding * 2 + timeHeight
    }
}
