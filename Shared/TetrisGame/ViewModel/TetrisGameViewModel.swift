//
//  TetrisGameViewModel.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import SwiftUI

class TetrisGameViewModel: ObservableObject {
	var rows: Int
	var columns: Int
	@Published var board: [[TetrisGameSquare]]

	init(rows: Int = 23, columns: Int = 10) {
		self.rows = rows
		self.columns = columns

		let repeating = Array(repeating: TetrisGameSquare(color: .black), count: rows)
		board = Array(repeating: repeating, count: columns)
	}

	func squareClicked(row: Int, column: Int) {
		if board[row][column].color == .black {
			board[row][column].color = .red
		} else {
			board[row][column].color = .black
		}
	}

}

struct TetrisGameSquare {
	var color: Color
}
