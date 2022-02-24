//
//  TetrisGameModel.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import SwiftUI

class TetrisGameModel: ObservableObject {
	var rows: Int
	var columns: Int
	@Published var board: [[TetrisGameBlock?]]
	@Published var tetromino: Tetromino?

	init(rows: Int = 23, columns: Int = 10) {
		self.rows = rows
		self.columns = columns

		board = Array(repeating: Array(repeating: nil, count: rows), count: columns)
		tetromino = .init(origin: .init(row: 22, column: 4), blockType: .i)
	}

	func squareClicked(row: Int, column: Int) {
		if board[column][row] == nil {
			board[column][row] = TetrisGameBlock(type: TetrisGameBlockType.allCases.randomElement()!)
		} else {
			board[column][row] = nil
		}
	}

}

struct TetrisGameBlock {
	var type: TetrisGameBlockType
}

