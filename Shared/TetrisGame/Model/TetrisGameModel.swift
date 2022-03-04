//
//  TetrisGameModel.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import SwiftUI

class TetrisGameModel: ObservableObject {

	///  Количество строк
	var rows: Int

	/// Количество столбцов
	var columns: Int

	/// Игровая доска
	@Published var board: [[TetrisGameBlock?]]

	///
	@Published var tetromino: Tetromino?

	/// Таймер
	var timer: Timer?

	/// Скорость
	var speed: Double


	var shadow: Tetromino? {
		guard var lastShadow = tetromino else { return nil }
		var testShadow = lastShadow
		while(isValidTetromino(testShadow)) {
			lastShadow = testShadow
			testShadow = lastShadow.moveBy(row: -1, column: 0)
		}

		return lastShadow
	}

	init(rows: Int = 23, columns: Int = 10) {
		self.rows = rows
		self.columns = columns

		board = Array(repeating: Array(repeating: nil, count: rows), count: columns)
		speed = 0.5
		resumeGame()
	}

	func resumeGame() {
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true, block: runEngine)
	}

	func pauseGame() {
		timer?.invalidate()
	}

	func runEngine(timer: Timer) {
		guard !clearLines() else { return }


		guard tetromino != nil else {
			tetromino = Tetromino.createNewTetromino(rows: rows, columns: columns)
			if !isValidTetromino(tetromino!) {
				pauseGame()
			}
			return
		}

		guard !moveTetrominoDown() else { return }

		placeTetromino()
	}

}

// MARK: - Actions with tetromino

extension TetrisGameModel {

	/// Полное смещение вниз
	func dropTetromino() {
		while(moveTetrominoDown()) { }
	}

	/// Смещение вправо
	@discardableResult
	func moveTetrominoRight() -> Bool {
		return moveTetromino(rowOffset: 0, columnOffset: 1)
	}

	/// Смещение влево
	@discardableResult
	func moveTetrominoLeft() -> Bool {
		return moveTetromino(rowOffset: 0, columnOffset: -1)
	}

	/// Смещение вниз
	@discardableResult
	func moveTetrominoDown() -> Bool {
		return moveTetromino(rowOffset: -1, columnOffset: 0)
	}

	/// Передвинуть блок
	/// - Parameter rowOffset: Смещение строки
	/// - Parameter columnOffset: Смещение столбца
	@discardableResult
	func moveTetromino(rowOffset: Int, columnOffset: Int) -> Bool {
		guard let currentTetromino = tetromino else { return false }

		let newTetromino = currentTetromino.moveBy(row: rowOffset, column: columnOffset)
		if isValidTetromino(newTetromino) {
			tetromino = newTetromino
			return true
		}

		return false
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

	func rotateTetromino(clockwise: Bool) {
		guard let currentTetromino = tetromino else { return }

		let newTetrominoBase = currentTetromino.rotate(clockwise: clockwise)
		let kicks = currentTetromino.getKicks(clockwise: clockwise)

		for kick in kicks {
			let newTetromino = newTetrominoBase.moveBy(row: kick.row, column: kick.column)
			if isValidTetromino(newTetromino) {
				tetromino = newTetromino
				return
			}
		}
	}

}

extension TetrisGameModel {

	func clearLines() -> Bool {
		var newBoard: [[TetrisGameBlock?]] = Array(repeating: Array(repeating: nil, count: rows), count: columns)
		var boardUpdated = false
		var nextRowToCopy = 0

		for row in 0...rows - 1 {
			var clearLine = true

			for column in 0...columns - 1 {
				clearLine = clearLine && board[column][row] != nil
			}

			if !clearLine {
				for column in 0...columns - 1 {
					newBoard[column][nextRowToCopy] = board[column][row]
				}
				nextRowToCopy += 1
			}
			boardUpdated = boardUpdated || clearLine
		}

		if boardUpdated {
			board = newBoard
		}

		return boardUpdated
	}

}

