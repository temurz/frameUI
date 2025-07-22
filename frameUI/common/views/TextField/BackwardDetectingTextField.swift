//
//  BackwardDetectingTextField.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit

// The same as UITextField but can recognize when user presses "delete" or "<" button on keyboard
class BackwardDetectingTextField: UITextField {
    weak var backspaceDelegate: BackspaceDetectingTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        backspaceDelegate?.textFieldDidDeleteBackward(self)
    }
}

protocol BackspaceDetectingTextFieldDelegate: AnyObject {
    func textFieldDidDeleteBackward(_ textField: UITextField)
}
