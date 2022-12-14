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
            return DisplayText(title: "æ®éð",
                               message: "\nã¿ããã©ã€ã³ãšã®å·®ã¯ã\(difference)\næ®éã®ãã¬ãŒã§ã")
        case .bravo(let difference):
            return DisplayText(title: "ãã©ããŒð",
                               message: "\nã¿ããã©ã€ã³ãšã®å·®ã¯ã\(difference)\nããªãã¯ç¥ã§ãã")
        case .bad(let difference):
            return DisplayText(title: "è«å€ð",
                               message: "\nã¿ããã©ã€ã³ãšã®å·®ã¯ã\(difference)\nãããèšèãèŠåœãããŸãã")
        }
    }
    
    struct DisplayText {
        let title: String
        let message: String
    }
}

