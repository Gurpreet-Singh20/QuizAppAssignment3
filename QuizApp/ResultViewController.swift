//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-16.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score: Int = 0
        var totalQuestions: Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "My Quiz"
            // Display the score in the label
            scoreLabel.text = "Your Score: \(score) out of \(totalQuestions)"
        }
        
        
   
}
