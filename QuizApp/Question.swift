//
//  Question.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-08.
//

import Foundation

class Question {
    var questionText: String
       var correctAnswer: String
       var incorrectAnswers: [String]
       var allAnswers: [String]
       
       init(questionText: String, correctAnswer: String, incorrectAnswers: [String]) {
           self.questionText = questionText
           self.correctAnswer = correctAnswer
           self.incorrectAnswers = incorrectAnswers
           
           self.allAnswers = ([correctAnswer] + incorrectAnswers).shuffled()
       }
}
