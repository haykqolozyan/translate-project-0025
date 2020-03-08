//
//  TranslationViewController.swift
//  TranslaterProject
//
//  Created by Hayk Qolozyan on 3/7/20.
//  Copyright © 2020 Hayk Qolozyan. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var translationWordTextField: UITextField!
    
    
    // MARK: - Private Properties
    private var viewPresenter: TranslationViewPresenter!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
    }
    
    
    // MARK: - Private Methods
    private func setupController() {
        
        translationWordTextField.delegate = self
        
        setupViewPresenter()
    }
    
    private func setupViewPresenter() {
        
        viewPresenter = TranslationViewPresenter()
        viewPresenter.delegate = self
    }
    
    private func lastIndexPath() -> NSIndexPath? {
        
        var indexPath: NSIndexPath? = nil
        var section: Int = tableView.numberOfSections - 1
        
        repeat {
            
            let numberOfRowsInSection = tableView.numberOfRows(inSection: section)
            
            if numberOfRowsInSection > 0 {
                
                indexPath = NSIndexPath(row: numberOfRowsInSection - 1, section: section)
                break
            }
            
            section -= 1
        } while section > 0
        
        return indexPath
    }
}

extension TranslationViewController: TranslationViewPresenterDelegate {
    
    func didFetchTranslations(sender: TranslationViewPresenter) {
        
        tableView.reloadData()
    }
}

extension TranslationViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let translatedWord = viewPresenter.translation(at: indexPath) {
            
            guard let viewController: TranslationDetailViewController = UIManager.viewControllerWith(controllerClass: TranslationDetailViewController.self, storyboard: .StoryboardMain) as? TranslationDetailViewController else {
                
                return
            }
            
            viewController.translatedWord = translatedWord
            self.show(viewController, sender: self)
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.compare(lastIndexPath()! as IndexPath) == .orderedSame {
            
            if viewPresenter.hasMoreTranslations {
                viewPresenter.fetchTranslations(isUpdateData: false)
            }
        }
    }
}

extension TranslationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewPresenter.numberOfTranslations()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        
        if let translation = viewPresenter.translation(at:indexPath) {
            cell.textLabel?.text = translation.translation.text
        }
        
        return cell
    }
}

extension TranslationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let translateString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        TranslationTimerManager.shared.setTimer(duration: 1, timerCompletionBlock: {
            
            self.viewPresenter.hasMoreTranslations = true
            self.viewPresenter.translateString = translateString
            self.viewPresenter.fetchTranslations(isUpdateData: true)
        })
        
        return true
    }
}

