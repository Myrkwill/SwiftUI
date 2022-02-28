//
//  Tetromino.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import SwiftUI

struct Tetromino {
	/// Место нахождения
	var origin: TetrisBlockLocation

	/// Тип плока
	var blockType: TetrisGameBlockType

	/// Какая сторона
	var rotation: Int

	// Блоки
	var blocks: [TetrisBlockLocation] {
		return Tetromino.getBlocks(blockType: blockType, rotation: rotation)
	}

	func moveBy(row: Int, column: Int) -> Tetromino {
		let newOrigin = TetrisBlockLocation(row: origin.row + row, column: origin.column + column)
		return Tetromino(origin: newOrigin, blockType: blockType, rotation: rotation)
	}

	func rotate(clockwise: Bool) -> Tetromino {
		return Tetromino(origin: origin, blockType: blockType, rotation: rotation + (clockwise ? 1 : -1))
	}

}

// MARK: - 

extension Tetromino {

	/// Получение блоков
	/// - Parameter blockType: Тип блока
	/// - Parameter rotation: По умолчанию 0
	static func getBlocks(blockType: TetrisGameBlockType, rotation: Int = 0) -> [TetrisBlockLocation] {
		let allBlocks = getAllBlocks(blockType: blockType)

		var index = rotation % allBlocks.count
		if (index < 0) { index += allBlocks.count}

		return allBlocks[index]
	}

	static func getAllBlocks(blockType: TetrisGameBlockType) -> [[TetrisBlockLocation]] {
		switch blockType {
		case .i:
			return [[.init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: 0, column: 2)],
					[.init(row: -1, column: 1), .init(row: 0, column: 1), .init(row: 1, column: 1), .init(row: -2, column: 1)],
					[.init(row: -1, column: -1), .init(row: -1, column: 0), .init(row: -1, column: 1), .init(row: -1, column: 2)],
					[.init(row: -1, column: 0), .init(row: 0, column: 0), .init(row: 1, column: 0), .init(row: -2, column: 0)]]
		case .o:
			return [[.init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: 1, column: 1), .init(row: 1, column: 0)]]
		case .t:
			return [[.init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: 1, column: 0)],
					[.init(row: -1, column: 0), .init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: 1, column: 0)],
					[.init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: -1, column: 0)],
					[.init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: 1, column: 0), .init(row: -1, column: 0)]]
		case .j:
			return [[.init(row: 1, column: -1), .init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: 0, column: 1)],
					[.init(row: 1, column: 0), .init(row: 0, column: 0), .init(row: -1, column: 0), .init(row: 1, column: 1)],
					[.init(row: -1, column: 1), .init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: 0, column: 1)],
					[.init(row: 1, column: 0), .init(row: 0, column: 0), .init(row: -1, column: 0), .init(row: -1, column: -1)]]
		case .l:
			return [[.init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: 1, column: 1)],
					[.init(row: 1, column: 0), .init(row: 0, column: 0), .init(row: -1, column: 0), .init(row: -1, column: 1)],
					[.init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: -1, column: -1)],
					[.init(row: 1, column: 0), .init(row: 0, column: 0), .init(row: -1, column: 0), .init(row: 1, column: -1)]]
		case .s:
			return [[.init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: 1, column: 0), .init(row: 1, column: 1)],
					[.init(row: 1, column: 0), .init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: -1, column: 1)],
					[.init(row: 0, column: 1), .init(row: 0, column: 0), .init(row: -1, column: 0), .init(row: -1, column: -1)],
					[.init(row: 1, column: -1), .init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: -1, column: 0)]]
		case .z:
			return [[.init(row: 1, column: -1), .init(row: 1, column: 0), .init(row: 0, column: 0), .init(row: 0, column: 1)],
					[.init(row: 1, column: 1), .init(row: 0, column: 1), .init(row: 0, column: 0), .init(row: -1, column: 0)],
					[.init(row: 0, column: -1), .init(row: 0, column: 0), .init(row: -1, column: 0), .init(row: -1, column: 1)],
					[.init(row: 1, column: 0), .init(row: 0, column: 0), .init(row: 0, column: -1), .init(row: -1, column: -1)]]
		}
	}

	static func createNewTetromino(rows: Int, columns: Int) -> Tetromino {
		let blockType = TetrisGameBlockType.allCases.randomElement()!

		var maxRow = 0
		for block in getBlocks(blockType: blockType) {
			maxRow = max(maxRow, block.row)
		}

		let origin = TetrisBlockLocation(row: rows - 1 - maxRow, column: (columns - 1) / 2)
		return Tetromino(origin: origin, blockType: blockType, rotation: 0)
	}

}

extension Tetromino {

	func getKicks(clockwise: Bool) -> [TetrisBlockLocation] {
		return Tetromino.getKicks(blockType: blockType, rotation: rotation, clockwise: clockwise)
	}

	static func getKicks(blockType: TetrisGameBlockType, rotation: Int, clockwise: Bool) -> [TetrisBlockLocation] {
		let rotationCount = getAllBlocks(blockType: blockType).count

		var index = rotation % rotationCount
		if index < 0 { index += rotationCount }

		var kicks = getAllKicks(blockType: blockType)[index]
		if !clockwise {
			var counterKicks: [TetrisBlockLocation] = []
			for kick in kicks {
				counterKicks.append(.init(row: -1 * kick.row, column: -1 * kick.column))
			}
			kicks = counterKicks
		}
		return kicks
	}

	static func getAllKicks(blockType: TetrisGameBlockType) -> [[TetrisBlockLocation]] {
		switch blockType {
		case .o:
			return [[.init(row: 0, column: 0)]]
		case .i:
			return [[.init(row: 0, column: 0), .init(row: 0, column: -2), .init(row: 0, column: 1), .init(row: -1, column: -2), .init(row: 2, column: -1)],
					[.init(row: 0, column: 0), .init(row: 0, column: -1), .init(row: 0, column: 2), .init(row: 2, column: -1), .init(row: -1, column: 2)],
					[.init(row: 0, column: 0), .init(row: 0, column: 2), .init(row: 0, column: -1), .init(row: 1, column: 2), .init(row: -2, column: -1)],
					[.init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: 0, column: -2), .init(row: -2, column: 1), .init(row: 1, column: -2)]
			]
		case .j, .l, .s, .z, .t:
			return [[.init(row: 0, column: 0), .init(row: 0, column: -1), .init(row: 1, column: -1), .init(row: 0, column: -2), .init(row: -2, column: -1)],
					[.init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: -1, column: 1), .init(row: 2, column: 0), .init(row: 1, column: 2)],
					[.init(row: 0, column: 0), .init(row: 0, column: 1), .init(row: 1, column: 1), .init(row: -2, column: 0), .init(row: -2, column: 1)],
					[.init(row: 0, column: 0), .init(row: 0, column: -1), .init(row: -1, column: -1), .init(row: 2, column: 0), .init(row: 2, column: -1)]
			]
		}
	}

}
