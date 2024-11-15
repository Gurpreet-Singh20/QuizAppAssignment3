//
//  QuestionBankViewController.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-08.
//

import Foundation
import UIKit

class QuestionBankViewController: UITableViewController, QuestionDelegate {
    var questions: [Question] {
            return QuestionManager.shared.questions
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Question Bank"
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
        }
        
        @IBAction func addQuestionTapped(_ sender: UIBarButtonItem) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let questionBuilderVC = storyboard.instantiateViewController(withIdentifier: "QuestionBuilderViewController") as? QuestionBuilderViewController {
                questionBuilderVC.delegate = self
                navigationController?.pushViewController(questionBuilderVC, animated: true)
            }
        }

        override func numberOfSections(in tableView: UITableView) -> Int {
            return questions.count
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1 + questions[section].allAnswers.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let question = questions[indexPath.section]

            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
                cell.textLabel?.text = "Q: \(question.questionText)"
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                return cell
            } else {
               
                let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") ?? UITableViewCell(style: .default, reuseIdentifier: "AnswerCell")
                let answer = question.allAnswers[indexPath.row - 1] //
                cell.textLabel?.text = "• \(answer)"

               
                if answer == question.correctAnswer {
                    cell.textLabel?.textColor = .systemGreen
                } else {
                    cell.textLabel?.textColor = .label
                }
                return cell
            }
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let questionEditVC = storyboard.instantiateViewController(withIdentifier: "QuestionEditViewController") as? QuestionEditViewController {
               
               let selectedQuestion = questions[indexPath.section]
    
               questionEditVC.delegate = self
               questionEditVC.question = selectedQuestion
               questionEditVC.questionIndex = indexPath.section
               
               
               navigationController?.pushViewController(questionEditVC, animated: true)
           }
           
          
           tableView.deselectRow(at: indexPath, animated: true)
       }

        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Question \(section + 1)"
        }

        func didAddQuestion(_ question: Question) {
            QuestionManager.shared.questions.append(question)
            tableView.reloadData()
        }

        func didUpdateQuestion(_ question: Question, at index: Int) {
            QuestionManager.shared.questions[index] = question
            tableView.reloadData()
        }
    }
