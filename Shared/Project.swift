//
//  Game.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import SwiftUI

enum Project: Int {
	case qiuz = 1
	case tetris

	@ViewBuilder var view: some View {
		switch self {
		case .qiuz:
			QuizGameHome()
				.navigationBarTitle("")
				.navigationBarHidden(true)
		case .tetris:
			TetrisGameView()
				.navigationBarTitle("")
				.navigationBarHidden(true)
		}
	}

	var title: String {
		switch self {
		case .qiuz: return "Go To Quiz Game"
		case .tetris: return "Go To Tetris"
		}
	}

	var backgroundColor: Color {
		switch self {
		case .qiuz: return .orange
		case .tetris: return .blue
		}
	}
}
