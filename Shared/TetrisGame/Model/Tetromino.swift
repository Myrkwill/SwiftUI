//
//  Tetromino.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import SwiftUI

struct Tetromino {
	var origin: TetrisBlockLocation
	var blockType: TetrisGameBlockType

	var blocks: [TetrisBlockLocation] {
		return Tetromino.getBlocks(blockType: blockType)
	}

	func moveBy(row: Int, column: Int) -> Tetromino {
		let newOrigin = TetrisBlockLocation(row: origin.row + row, column: origin.column + column)
		return Tetromino(origin: newOrigin, blockType: blockType)
	}

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
		return Tetromino(origin: origin, blockType: blockType)
	}

}
