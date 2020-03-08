//
//  UIManager.swift
//  TranslaterProject
//
//  Created by Hayk Qolozyan on 3/7/20.
//  Copyright © 2020 Hayk Qolozyan. All rights reserved.
//

import UIKit

enum Storyboard {
    case StoryboardMain
}

class UIManager {
    
    // MARK: - Public Methods
    static func viewControllerWith(controllerClass: AnyClass, storyboard: Storyboard) -> UIViewController? {
        
        let storyboardName = nameForStoryboard(storyboard: storyboard)
        
        let selectedStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let viewController: UIViewController = selectedStoryboard.instantiateViewController(withIdentifier: NSStringFromClass(controllerClass.self))
        
        if viewController.isKind(of: controllerClass) {
            return viewController
        }
        else {
            return nil
        }
    }
    
    
    // MARK: - Private Methods
    static func nameForStoryboard(storyboard: Storyboard) -> String {
        
        var storybardName: String = ""
        
        switch storyboard {
            
        case .StoryboardMain:
            
            storybardName = "Main"
            break
        }
        
        return storybardName
    }
}

