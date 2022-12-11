//
//  GameResult.swift
//  BraBall
//

import Foundation

enum GameResult {
    case none
    case normal(CGFloat)
    case bravo(CGFloat)
    case bad(CGFloat)
    
    init(from difference: CGFloat) {
        switch difference {
        case 0.01..<2:
            self = .bravo(difference)
        case 2...10:
            self = .normal(difference)
        default:
            self = .bad(difference)
        }
    }
    
    var title: String {
        self.displayText.title
    }
    
    var message: String {
        self.displayText.message
    }
    
    private var displayText: DisplayText {
        switch self {
        case .none:
            return DisplayText(title: "",
                               message: "")
        case .normal(let difference):
            return DisplayText(title: "普通😑",
                               message: "\nタッチラインとの差は、\(difference)\n普通のプレーです")
        case .bravo(let difference):
            return DisplayText(title: "ブラボー🎉",
                               message: "\nタッチラインとの差は、\(difference)\nあなたは神です。")
        case .bad(let difference):
            return DisplayText(title: "論外💀",
                               message: "\nタッチラインとの差は、\(difference)\nかける言葉も見当たりません")
        }
    }
    
    struct DisplayText {
        let title: String
        let message: String
    }
}

