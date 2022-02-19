//
//  QuizGamePuzzle.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 19.02.2022.
//

import SwiftUI

// Модель позла
struct QuizGamePuzzle: Identifiable {
	///  Идентификатор
	var id: String = UUID().uuidString

	/// Имя картинки
	var imageName: String

	/// Ответ
	var answer: String

	/// Слово, из которого выстраиивается верное слово
	var jumbbledWord: String

}

let puzzles: [QuizGamePuzzle] = [
	.init(imageName: "crown", answer: "Crown", jumbbledWord: "CUROROWKN")
]
