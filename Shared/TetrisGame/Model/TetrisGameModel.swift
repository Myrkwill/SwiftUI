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
		guard tetromino != nil else {
			tetromino = Tetromino.createNewTetromino(rows: rows, columns: columns)
			if !isValidTetromino(tetromino!) {
				pauseGame()
				return
			}
			return
		}

		guard !moveTetrominoDown() else { return }

		placeTetromino()
	}

}

// MARK: - Actions with tetromino

private extension TetrisGameModel {

	/// Полное смещение вниз
	func dropTetromino() {
		while(moveTetrominoDown()) { }
	}

	/// Смещение вправо
	func moveTetrominoRight() -> Bool {
		return moveTetromino(rowOffset: 0, columnOffset: 1)
	}

	/// Смещение влево
	func moveTetrominoLeft() -> Bool {
		return moveTetromino(rowOffset: 0, columnOffset: -1)
	}

	/// Смещение вниз
	func moveTetrominoDown() -> Bool {
		return moveTetromino(rowOffset: -1, columnOffset: 0)
	}

	/// Передвинуть блок
	/// - Parameter rowOffset: Смещение строки
	/// - Parameter columnOffset: Смещение столбца
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

}

