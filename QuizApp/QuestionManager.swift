//
//  QuestionManager.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-15.
//

import Foundation

class QuestionManager {
    static let shared = QuestionManager()
       var questions: [Question] = []
       
       private init() {}
       
      
       func addQuestion(questionText: String, correctAnswer: String, incorrectAnswers: [String]) {
           let question = Question(questionText: questionText, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers)
           questions.append(question)
       }
}
