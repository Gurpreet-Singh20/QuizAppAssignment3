//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-14.
//

import Foundation
import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var currentQuestionIndex = 0
        var score = 0
        
       
        let questionManager = QuestionManager.shared
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "My Quiz"
            updateQuestion()
            updateProgressBar()
            resultLabel.isHidden = true
            previousButton.isHidden = true
            optionsTableView.delegate = self
            optionsTableView.dataSource = self
            
           
            loadQuestion()
        }
        
        func loadQuestion() {
            let currentQuestion = QuestionManager.shared.questions[currentQuestionIndex]
                questionLabel.text = currentQuestion.questionText
                optionsTableView.reloadData()
        }
        
       
        func updateQuestion() {
            let currentQuestion = questionManager.questions[currentQuestionIndex]
                
                
                questionLabel.text = currentQuestion.questionText
                
                optionsTableView.reloadData()
                
                updateProgressBar()
                
                resultLabel.isHidden = true
        }
        
       
        func updateProgressBar() {
            let progress = Float(currentQuestionIndex + 1) / Float(questionManager.questions.count)
            progressBar.setProgress(progress, animated: true)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return questionManager.questions[currentQuestionIndex].allAnswers.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
                let currentQuestion = questionManager.questions[currentQuestionIndex]
                cell.textLabel?.text = currentQuestion.allAnswers[indexPath.row]
                return cell
        }
        
       
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let currentQuestion = questionManager.questions[currentQuestionIndex]
            let selectedAnswer = currentQuestion.allAnswers[indexPath.row]
            

            if selectedAnswer == currentQuestion.correctAnswer {
                score += 1
            }
            
           
            resultLabel.isHidden = false
            resultLabel.text = selectedAnswer == currentQuestion.correctAnswer ? "Correct!" : "Incorrect"
            
            
            optionsTableView.isUserInteractionEnabled = false
        }
        
       
        @IBAction func nextButtonTapped(_ sender: UIButton) {
            if currentQuestionIndex < questionManager.questions.count - 1 {
                currentQuestionIndex += 1
                updateQuestion()
                optionsTableView.isUserInteractionEnabled = true
            }
            
            
            if currentQuestionIndex == questionManager.questions.count - 1 {
                nextButton.isHidden = true
            }
            
           
            previousButton.isHidden = false
        }
        
        @IBAction func previousButtonTapped(_ sender: UIButton) {
            if currentQuestionIndex > 0 {
                currentQuestionIndex -= 1
                updateQuestion()
                optionsTableView.isUserInteractionEnabled = true
            }
            
            
            if currentQuestionIndex == 0 {
                previousButton.isHidden = true
            }
            
            nextButton.isHidden = false
        }
        
        func showFinalResult() {
            resultLabel.isHidden = false
            resultLabel.text = "Your Score: \(score) / \(questionManager.questions.count)"
            nextButton.isHidden = true
            previousButton.isHidden = true
        }
        
       
        func checkIfQuizCompleted() {
            if currentQuestionIndex == questionManager.questions.count - 1 {
                showFinalResult()
            }
        }
        
        @IBAction func finishQuiz(_ sender: UIButton) {
            performSegue(withIdentifier: "showResultSegue", sender: nil)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showResultSegue" {
                if let resultVC = segue.destination as? ResultViewController {
                    resultVC.score = score
                    resultVC.totalQuestions = questionManager.questions.count
                }
            }
        }
    }
