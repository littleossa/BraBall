//
//  SoccerField.swift
//  BraBall
//

import SwiftUI

struct SoccerField: View {
    
    @Binding var outsideTouchLineRect: CGRect
    
    var body: some View {
        
        GeometryReader { proxy in
            let screenWidth = proxy.size.width
            
            HStack(spacing: 32) {
                Rectangle()
                    .fill(.green)
                    .frame(width: screenWidth * 0.45)
                Rectangle()
                    .fill(.green)
                    .readFrame($outsideTouchLineRect)
            }
        }
    }
}

struct SoccerField_Previews: PreviewProvider {
    static var previews: some View {
        SoccerField(outsideTouchLineRect: .constant(CGRect()))
    }
}
