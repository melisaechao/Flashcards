//
//  ViewController.swift
//  Flashcards
//
//  Created by Melissa Saechao on 9/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        
       
        
        // Do any additional setup after loading the view.
    }

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
        frontLabel.isHidden = true
        
    }
    
    func updateFlahcard(question: String, answer: String) {

        frontLabel.text = question
        backLabel.text = answer
    
    }
    
    
}

