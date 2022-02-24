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
		tetrisGameModel.board.map { $0.map(convertToSquare) }
	}

	var anyCancellable: AnyCancellable?

	init() {
		anyCancellable = tetrisGameModel.objectWillChange.sink {
			self.objectWillChange.send()
		}
	}

	func convertToSquare(block: TetrisGameBlock?) -> TetrisGameSquare {
		return TetrisGameSquare(color: color(for: block?.type))
	}

	//
	func color(for blockType: TetrisGameBlockType?) -> Color {
		guard let blockType = blockType else { return .tetrisBlack }
		return blockType.color
	}


	func squareClicked(row: Int, column: Int) {
		tetrisGameModel.squareClicked(row: row, column: column)
	}

}

struct TetrisGameSquare {
	var color: Color
}
