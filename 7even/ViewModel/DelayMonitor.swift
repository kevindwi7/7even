//
//  DelayMonitor.swift
//  7even
//
//  Created by Inez Amanda on 19/07/22.
//

import SwiftUI

class DelayMonitor: ObservableObject {
    var timer = Timer()
    @Published var seconds: Double = 0.0
    @Published var failed: Bool = false
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.seconds += 1.0
            if self.seconds == 30.0 { // arbitrary timeout
                self.timer.invalidate()
                DispatchQueue.main.async() {
                    [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.failed = true
                    print(strongSelf.failed)
                }
            }
        })
    }
    
    func stop() {
        self.timer.invalidate()
    }
}
