//
//  TranslationViewPresenter.swift
//  TranslaterProject
//
//  Created by Hayk Qolozyan on 3/7/20.
//  Copyright © 2020 Hayk Qolozyan. All rights reserved.
//

import UIKit

protocol TranslationViewPresenterDelegate:class {
    
    func didFetchTranslations(sender: TranslationViewPresenter)
}

class TranslationViewPresenter {
    
    // MARK: - Public Properties
    public weak var delegate: TranslationViewPresenterDelegate?
    public var hasMoreTranslations: Bool = true
    public var translateString: String = ""
    
    
    // MARK: - Private Properties
    private var translationsList: [MeaningsStruct] = []
    private var pageNumber: Int = 0
    private var pageSize: Int = 20
    
    
    // MARK: - Public Methods
    func fetchTranslations(isUpdateData: Bool) {
        
        if hasMoreTranslations {
            
            pageNumber += 1
            fetchTranslations(with: pageNumber,
                              pageSize: pageSize,
                              translateString: translateString,
                              updateData: isUpdateData)
        }
    }
    
    
    // MARK: - Private Methods
    private func fetchTranslations(with pageNumber: Int, pageSize: Int, translateString: String, updateData: Bool)  {
        
        APIService.fetchMeanings(with: pageNumber, pageSize: pageSize, translateString: translateString) { (responseObject, error) in
            
            guard let responseSrtucts = responseObject else {
                print(error as Any)
                return
            }
            
            let meaningsObjects = responseSrtucts.map { $0.meanings }
            
            if updateData {
                self.translationsList.removeAll()
            }
            
            for meaningsList in meaningsObjects {
                self.translationsList.append(contentsOf: meaningsList)
            }
            
            self.hasMoreTranslations = (self.pageSize == meaningsObjects.count)
            self.delegate?.didFetchTranslations(sender: self)
        }
    }
    
    
    // MARK: - TableView drawing Methods
    func numberOfTranslations() -> Int {
        
        var translationsListCount: Int = 0
        
        if translationsList.count > 0  {
            translationsListCount = translationsList.count
        }
        
        return translationsListCount
    }
    
    func translation(at index: IndexPath) -> MeaningsStruct? {
        
        if (index.row < translationsList.count) {
            
            let translation = translationsList[index.row]
            return translation
        }
        
        return nil
    }
}
