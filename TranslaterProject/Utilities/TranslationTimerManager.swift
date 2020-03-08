//
//  TranslationTimerManager.swift
//  TranslaterProject
//
//  Created by Hayk Qolozyan on 3/7/20.
//  Copyright © 2020 Hayk Qolozyan. All rights reserved.
//

import UIKit

class TranslationTimerManager {
    
    static let shared = TranslationTimerManager()
    var timer: Timer?
    
    public func setTimer(duration: Double, timerCompletionBlock: @escaping() -> Void) -> () {
        
        self.resetTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: { (_) in
            
            timerCompletionBlock()
            self.resetTimer()
        })
    }
    
    func resetTimer() {
        
        timer?.invalidate()
        timer = nil
    }
}
