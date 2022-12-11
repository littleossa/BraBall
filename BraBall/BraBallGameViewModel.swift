//
//  BraBallGameViewModel.swift
//  BraBall
//

import CoreMotion

class BraBallGameViewModel: ObservableObject {
    
    init() {
        startMotion()
    }
    
    @Published var currentBallPosition: CGPoint = .init()
    @Published var outsideTouchLineField: CGRect = .init()
    @Published var shouldPresentedResult = false
    @Published var result: GameResult = .none
    
    let ballLength: CGFloat = 120
        
    private let motionManager = CMMotionManager()
    private var screenRect = CGRect()
    
    private var currentBallMinX: CGFloat {
        currentBallPosition.x - ballLength / 2
    }
    
    private var touchLineMaxX: CGFloat {
        outsideTouchLineField.minX
    }
    
    // MARK: - Public Function
    
    func setupScreenRect(_ rect: CGRect) {
        screenRect = rect
    }
    
    func judgeBallPosition() {
        guard motionManager.isDeviceMotionActive
        else { return }
        
        motionManager.stopDeviceMotionUpdates()
        
        let difference = touchLineMaxX - currentBallMinX
        print("difference", difference)
        
        result = GameResult(from: difference.roundedAfterThirdDecimalPlace())
        shouldPresentedResult = true
    }
    
    func retryGame() {
        result = .none
        startMotion()
    }
    
    // MARK: - Private Function
    
    private func startMotion() {
        
        guard let queue = OperationQueue.current,
              motionManager.isDeviceMotionAvailable
        else { return }
        
        motionManager.deviceMotionUpdateInterval = 1 / 100
        motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical,
                                               to: queue) { [weak self] motion, error in
            
            guard let self = self,
                  let motion = motion,
                  error == nil
            else { return }
            
            let xAngle = motion.attitude.roll * 180 / Double.pi
            let yAngle = motion.attitude.pitch * 180 / Double.pi
                                    
            /// 係数を使って感度を調整する
            let coefficient: CGFloat = 5
            
            let regulatedX = CGFloat(xAngle) * coefficient
            let regulatedY = CGFloat(yAngle) * coefficient
            
            let currentPositionX = self.calculatedCurrentPositionX(byAdding: regulatedX)
            let currentPositionY = self.calculatedCurrentPositionY(byAdding: regulatedY)
            
            print("x: ", currentPositionX)
            print("y: ", currentPositionY)
           
            Task { @MainActor in
                self.currentBallPosition = CGPoint(x: currentPositionX,
                                                   y: currentPositionY)
            }
        }
    }
    
    /// 与えられたxと現在のターゲットの位置xを合算し、必要であればスクリーンの内側の値になるように補正された値を算出する
    /// - Parameter x: 現在のターゲットの位置xを算出する為に追加する値
    /// - Returns: 算出された現在のターゲットの位置x
    private func calculatedCurrentPositionX(byAdding x: CGFloat) -> CGFloat {
        var position = currentBallPosition
        position.x += x
        if screenRect.minX > position.x {
            position.x = screenRect.minX
        } else if screenRect.maxX < position.x {
            position.x = screenRect.maxX
        }
        return position.x
    }
    
    /// 与えられたyと現在のターゲットの位置yを合算し、必要であればスクリーンの内側の値になるように補正された値を算出する
    /// - Parameter x: 現在のターゲットの位置yを算出する為に追加する値
    /// - Returns: 算出された現在のターゲットの位置y
    private func calculatedCurrentPositionY(byAdding y: CGFloat) -> CGFloat {
        var position = currentBallPosition
        position.y += y
        if screenRect.minY > position.y {
            position.y = screenRect.minY
        } else if screenRect.maxY < position.y {
            position.y = screenRect.maxY
        }
        return position.y
    }
}
