//
//  QuizGamePuzzle.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 19.02.2022.
//

import SwiftUI

// Модель позла
struct QuizGamePuzzle: Identifiable {

	var id: String = UUID().uuidString
	var imageName: String
	var answer: String

	/// Слово, из которого выстраиивается верное слово
	var jumbbledWord: String

	///
	var latters: [QuizGameLatter] = []

}

struct QuizGameLatter {

	var id: String = UUID().uuidString
	var value: String
}

let puzzles: [QuizGamePuzzle] = [
	.init(imageName: "crown", answer: "Crown", jumbbledWord: "CUROROWKN")
]
