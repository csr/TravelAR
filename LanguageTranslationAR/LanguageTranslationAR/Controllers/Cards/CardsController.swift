//
//  CardsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import ZLSwipeableViewSwift

class CardsController: UIViewController {
    
    private var dictionary = [String: String]()
    
    private var swipeableView: ZLSwipeableView = {
        let swipeableView = ZLSwipeableView()
        swipeableView.numberOfActiveView = 3
        swipeableView.translatesAutoresizingMaskIntoConstraints = false
        return swipeableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeableView.nextView = {
            return self.nextCardView()
        }
        
        swipeableView.didTap = { view, location in
            guard let view = view as? CardView else {
                return
            }
            view.didTapCard()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.addSubview(swipeableView)
        setupSwipeableView()
        loadDictionary()
        animateFirstFlashcard()
    }
    
    private func animateFirstFlashcard() {
        perform(#selector(showCardAnimation), with: nil, afterDelay: 1)
        perform(#selector(showCardAnimation), with: nil, afterDelay: 2.5)
    }
    
    @objc func showCardAnimation() {
        if let card = swipeableView.activeViews().first as? CardView {
            card.didTapCard()
        }
    }

    private func setupSwipeableView() {
        view.addSubview(swipeableView)
        swipeableView.fillToSuperview(constant: 50)
    }

    private func loadDictionary() {
        if let loadedDict = loadJSONFile(fileName: "dictionary") as? [String: String] {
            self.dictionary = loadedDict
        }
    }
    
    private func getDictionaryItem() -> (String, String)? {
        if let entry = dictionary.randomElement() {
            return entry
        }
        return nil
    }
    
    var isFirstCard = false
    
    func nextCardView() -> CardView {
        let cardView = CardView(frame: swipeableView.bounds)
        cardView.dictionaryEntry = getDictionaryItem()
        return cardView
    }
}
