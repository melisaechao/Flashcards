//
//  ViewController.swift
//  Flashcards
//
//  Created by Melissa Saechao on 9/6/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readSavedFlashCards()
        
        if flashcards.count == 0 {
            updateFlahcard(question: "What's the capital of Brazil?", answer: "Brasilia")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
        
        card.layer.cornerRadius = 20
        backLabel.layer.cornerRadius = 20
        frontLabel.layer.cornerRadius = 20
        buttonOne.layer.cornerRadius = 20
        buttonTwo.layer.cornerRadius = 20
        buttonThree.layer.cornerRadius = 20
        
        backLabel.clipsToBounds = true
        frontLabel.clipsToBounds = true
        buttonOne.clipsToBounds = true
        buttonTwo.clipsToBounds = true
        buttonThree.clipsToBounds = true
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.4
        
        buttonOne.layer.borderWidth = 3.0
        buttonTwo.layer.borderWidth = 3.0
        buttonThree.layer.borderWidth = 3.0
        
    }
    
    // Do any additional setup after loading the view.
    
    
    @IBAction func didTapOnButtonOne(_ sender: Any) {
        buttonOne.isHidden = true
    }
    
    @IBAction func didTapOnButtonTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOnButtonThree(_ sender: Any) {
        buttonThree.isHidden = true
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
       flipFlashcard()
    }
    
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromTop, animations: {
            if self.frontLabel.isHidden == false {
                self.frontLabel.isHidden = true
            } else {
                self.frontLabel.isHidden = false
            }
        })
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardIn()
            
        })
    }
    
    func animateCardIn() {
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }

    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
        animateCardIn()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) { currentIndex = currentIndex + 1
        updateNextPrevButtons()
        animateCardOut()
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func updateFlahcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        flashcards.append(flashcard)
        currentIndex = flashcards.count - 1
        print("Added a new FlashCard, take a look")
        print("We now have \(flashcards.count) flashcards")
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashCardsToDisk()
    }
    
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func saveAllFlashCardsToDisk() {
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashCards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flascards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    
}
