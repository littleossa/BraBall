//
//  ContentView.swift
//  BraBall
//

import SwiftUI

struct BraBallGameView: View {
    
    @StateObject private var viewModel = BraBallGameViewModel()
    
    var body: some View {
        
        GeometryReader { proxy in
            
            let _ = viewModel.setupScreenRect(proxy.frame(in: .local))
            
            ZStack {
                
                SoccerField(outsideTouchLineRect: $viewModel.outsideTouchLineField)
                
                SoccerBall(length: viewModel.ballLength)
                    .position(viewModel.currentBallPosition)
            }
            .onTapGesture {
                viewModel.judge()
            }
            .alert(Text(viewModel.result.title),
                   isPresented: $viewModel.shouldPresentedResult,
                   actions: {
                
                Button {
                    viewModel.retryGame()
                } label: {
                    Text("リトライ")
                }
                
            }, message: {
                Text(viewModel.result.message)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BraBallGameView()
    }
}
