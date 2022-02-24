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

	var blocks: [TetrisBlockLocation] = [
		.init(row: 0, column: -1),
		.init(row: 0, column: 0),
		.init(row: 0, column: 1),
		.init(row: 0, column: 2),
	]
}

struct TetrisBlockLocation {
	var row: Int
	var column: Int
}
