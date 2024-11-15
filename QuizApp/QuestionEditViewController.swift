//
//  QuestionEditViewController.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-14.
//

import Foundation
import UIKit

class QuestionEditViewController: UIViewController {
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var firstIncorrectAnswerTextField: UITextField!
    @IBOutlet weak var secondIncorrectAnswerTextField: UITextField!
    @IBOutlet weak var thirdIncorrectAnswerTextField: UITextField!
    
    weak var delegate: QuestionDelegate?
       var question: Question?
       var questionIndex: Int?

       override func viewDidLoad() {
           super.viewDidLoad()
           
           
           if let question = question {
               questionTextField.text = question.questionText
               correctAnswerTextField.text = question.correctAnswer
               
               let incorrectAnswers = question.incorrectAnswers
               if incorrectAnswers.count >= 3 {
                   firstIncorrectAnswerTextField.text = incorrectAnswers[0]
                   secondIncorrectAnswerTextField.text = incorrectAnswers[1]
                   thirdIncorrectAnswerTextField.text = incorrectAnswers[2]
               }
           }
       }
       
       @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
           
           view.endEditing(true)
       
           guard let questionText = questionTextField.text, !questionText.isEmpty,
                 let correctAnswer = correctAnswerTextField.text, !correctAnswer.isEmpty,
                 let firstIncorrect = firstIncorrectAnswerTextField.text, !firstIncorrect.isEmpty,
                 let secondIncorrect = secondIncorrectAnswerTextField.text, !secondIncorrect.isEmpty,
                 let thirdIncorrect = thirdIncorrectAnswerTextField.text, !thirdIncorrect.isEmpty,
                 let index = questionIndex else {
               showValidationError()
               return
           }
           
         
           let updatedQuestion = Question(
               questionText: questionText,
               correctAnswer: correctAnswer,
               incorrectAnswers: [firstIncorrect, secondIncorrect, thirdIncorrect]
           )
           
          
           delegate?.didUpdateQuestion(updatedQuestion, at: index)
           
          
           navigationController?.popViewController(animated: true)
       }
       
       @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
          
           view.endEditing(true)
           navigationController?.popViewController(animated: true)
       }
       
       private func showValidationError() {
           let alert = UIAlertController(
               title: "Invalid Input",
               message: "Please ensure all fields are filled out.",
               preferredStyle: .alert
           )
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
   }
