//
//  TranslationDetailViewController.swift
//  TranslaterProject
//
//  Created by Hayk Qolozyan on 3/7/20.
//  Copyright © 2020 Hayk Qolozyan. All rights reserved.
//

import UIKit
import SDWebImage

@objc(TranslationDetailViewController)
class TranslationDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var translatedLabel: UILabel!
    @IBOutlet weak var translatedDescription: UITextView!
    
    
    // MARK: - Public Properties
    public var translatedWord: MeaningsStruct?
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
    }
    
    
    // MARK: - Private Methods
    private func setupController() {
        
        if let translatedModel = translatedWord {
            fillController(with: translatedModel)
        }
    }
    
    private func fillController(with meaningsStruct: MeaningsStruct) {
        
        translatedLabel.text = meaningsStruct.translation.text
        translatedDescription.text = meaningsStruct.translation.note
        
        if let imageUrl = URL(string: meaningsStruct.imageUrl!) {
            
            SDWebImageManager.shared.loadImage(with: imageUrl, options: [], progress: nil) { [weak self] (image, _, _, _, _, _) in
                
                guard let self = self else { return }
                
                if let image = image {
                    self.detailImageView.image = image
                }
                else {
                    self.detailImageView.image = UIImage.init(named: "placholder_icon")
                }
            }
        }
    }
    
}
