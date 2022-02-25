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

	var timer: Timer?
	var speed: Double

	init(rows: Int = 23, columns: Int = 10) {
		self.rows = rows
		self.columns = columns

		board = Array(repeating: Array(repeating: nil, count: rows), count: columns)
		tetromino = .init(origin: .init(row: 22, column: 4), blockType: .i)
		speed = 0.5
	}

	func squareClicked(row: Int, column: Int) {
		if board[column][row] == nil {
			board[column][row] = TetrisGameBlock(type: TetrisGameBlockType.allCases.randomElement()!)
		} else {
			board[column][row] = nil
		}
	}

	func resumeGame() {
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true, block: runEngine)
	}

	func pauseGame() {
		timer?.invalidate()
	}

	func runEngine(timer: Timer) {
		guard let currentTetromino = tetromino else {
			print("Спавн блока")
			tetromino = Tetromino(origin: TetrisBlockLocation(row: 22, column: 4), blockType: .i)
			if !isValidTetromino(tetromino!) {
				print("Game over")
				pauseGame()
				return
			}
			return
		}

		let newTetromino = currentTetromino.moveBy(row: -1, column: 0)
		if isValidTetromino(newTetromino) {
			print("Движение блока вниз")
			tetromino = newTetromino
			return
		}

		// see if we need to place the block
		print("Placing tetromino")
		placeTetromino()
	}

	func isValidTetromino(_ tetromino: Tetromino) -> Bool {
		for block in tetromino.blocks {
			let row = tetromino.origin.row + block.row
			if row < 0 || row >= rows { return false }

			let column = tetromino.origin.column + block.column
			if column < 0 || column >= columns { return false }

			if board[column][row] != nil { return false }
		}
		return true
	}

	func placeTetromino() {
		guard let currentTetromino = tetromino else { return }

		for block in currentTetromino.blocks {
			let row = currentTetromino.origin.row + block.row
			if row < 0 || row >= rows { continue }

			let column = currentTetromino.origin.column + block.column
			if column < 0 || column >= columns { continue }

			board[column][row] = TetrisGameBlock(type: currentTetromino.blockType)
		}

		tetromino = nil
	}

}

struct TetrisGameBlock {
	var type: TetrisGameBlockType
}

