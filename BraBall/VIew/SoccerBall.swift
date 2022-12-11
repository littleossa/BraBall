//
//  SoccerBall.swift
//  BraBall
//

import SwiftUI

struct SoccerBall: View {
    
    let length: CGFloat
    
    private var octagonSize: CGFloat {
        return length / 4
    }
    
    var body: some View {
        
        Image(systemName: "circle.fill")
            .font(.system(size: length))
            .foregroundColor(.white)
            .overlay {
                ZStack {
                    ForEach(BallOctagonAlignment.allCases) { alignment in
                        
                        Image(systemName: "octagon.fill")
                            .font(.system(size: octagonSize))
                            .fontWeight(.ultraLight)
                            .foregroundColor(.black)
                            .frame(width: length,
                                   height: length,
                                   alignment: alignment.value)
                    }
                }
                .clipShape(Circle())
            }
            .shadow(radius: 1)
    }
}

struct SoccerBall_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green
            SoccerBall(length: 160)
        }
    }
}

extension SoccerBall {
    
    enum BallOctagonAlignment: String, CaseIterable, Identifiable {
        
        case top
        case topTrailing
        case topLeading
        case center
        case centerTrailing
        case centerLeading
        case bottom
        case bottomTrailing
        case bottomLeading
        
        var id: String { return self.rawValue }
        
        var value: Alignment {
            switch self {
            case .top:
                return .top
            case .topTrailing:
                return .topTrailing
            case .topLeading:
                return .topLeading
            case .center:
                return .center
            case .centerTrailing:
                return .trailing
            case .centerLeading:
                return .leading
            case .bottom:
                return .bottom
            case .bottomTrailing:
                return .bottomTrailing
            case .bottomLeading:
                return .bottomLeading
            }
        }
    }
}
