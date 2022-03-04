//
//  TetrisGameViewModel.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import SwiftUI
import Combine

class TetrisGameViewModel: ObservableObject {

	@Published var tetrisGameModel = TetrisGameModel()

	var rows: Int { tetrisGameModel.rows }
	var columns: Int { tetrisGameModel.columns }

	var board: [[TetrisGameSquare]] {
		var board = tetrisGameModel.board.map { $0.map(convertToSquare) }

		if let shadow = tetrisGameModel.shadow {
			for blockLocation in shadow.blocks {
				board[blockLocation.column + shadow.origin.column][blockLocation.row + shadow.origin.row] = TetrisGameSquare(color: shadow.blockType.shadow)
			}
		}

		if let tetromino = tetrisGameModel.tetromino {
			for blockLocation in tetromino.blocks {
				board[blockLocation.column + tetromino.origin.column][blockLocation.row + tetromino.origin.row] = TetrisGameSquare(color: tetromino.blockType.color)
			}
		}

		return board
	}

	var anyCancellable: AnyCancellable?
	var lastMoveLocation: CGPoint?
	var lastRotateAngle: Angle?

	init() {
		anyCancellable = tetrisGameModel.objectWillChange.sink {
			self.objectWillChange.send()
		}
	}

	func convertToSquare(block: TetrisGameBlock?) -> TetrisGameSquare {
		// Если block == nil, то цвет черный
		return TetrisGameSquare(color: block?.type.color ?? .tetrisBlack)
	}

	func restartGame() {
		tetrisGameModel.restartGame()
	}

	func startGame() {
		tetrisGameModel.resumeGame()
	}

	func pauseGame() {
		tetrisGameModel.pauseGame()
	}

	func rotateGesture() -> some Gesture {
		let tap = TapGesture()
			.onEnded({self.tetrisGameModel.rotateTetromino(clockwise: true)})

		let rotate = RotationGesture()
			.onChanged(onRotateChanged(value:))
			.onEnded(onRotateEnd(value:))

		return tap.simultaneously(with: rotate)
	}

	func onRotateChanged(value: RotationGesture.Value) {
		guard let start = lastRotateAngle else {
			lastRotateAngle = value
			return
		}

		let diff = value - start
		if diff.degrees > 10 {
			tetrisGameModel.rotateTetromino(clockwise: true)
			lastRotateAngle = value
			return
		}

		if diff.degrees < -10 {
			tetrisGameModel.rotateTetromino(clockwise: false)
			lastRotateAngle = value
			return
		}
	}

	func onRotateEnd(value: RotationGesture.Value) {
		lastRotateAngle = nil
	}

	func moveGesture() -> some Gesture {
		return DragGesture()
			.onChanged(onMoveChanged(value:))
			.onEnded(onMoveEnded(_:))
	}

	func onMoveChanged(value: DragGesture.Value) {
		guard let start = lastMoveLocation else {
			lastMoveLocation = value.location
			return
		}

		let xDiff = value.location.x - start.x
		if xDiff > 10 {
			tetrisGameModel.moveTetrominoRight()
			lastMoveLocation = value.location
			return
		}
		if xDiff < -10 {
			tetrisGameModel.moveTetrominoLeft()
			lastMoveLocation = value.location
			return
		}

		let yDiff = value.location.y - start.y
		if yDiff > 10 {
			tetrisGameModel.moveTetrominoDown()
			lastMoveLocation = value.location
			return
		}
		if yDiff < -10 {
			tetrisGameModel.dropTetromino()
			lastMoveLocation = value.location
			return
		}
	}

	func onMoveEnded(_: DragGesture.Value) {
		lastMoveLocation = nil
	}


}

struct TetrisGameSquare {
	var color: Color
}
