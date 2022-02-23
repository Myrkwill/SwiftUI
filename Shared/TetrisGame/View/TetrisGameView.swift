//
//  TetrisGameView.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import SwiftUI

struct TetrisGameView: View {

	@ObservedObject var tetrisGame = TetrisGameViewModel()

    var body: some View {
		GeometryReader { proxy in
			drawBoard(rect: proxy.size)
		}
    }

	func drawBoard(rect: CGSize) -> some View {
		let rows = CGFloat(tetrisGame.rows)
		let columns = CGFloat(tetrisGame.columns)

		let blockSize = min(rect.width / columns, rect.height / rows)
		let xOffset = (rect.width - blockSize * columns) / 2
		let yOffset = (rect.height - blockSize * rows) / 2

		return ForEach(0...Int(columns) - 1, id: \.self) { column in
			ForEach(0...Int(rows) - 1, id: \.self) { row in
				Path { path in
					let x = xOffset + blockSize * CGFloat(column)
					let y = rect.height - yOffset - blockSize * CGFloat(row - 1)
					let pathRect = CGRect(x: x, y: y, width: blockSize, height: blockSize)
					path.addRect(pathRect)
				}
				.fill(tetrisGame.board[column][row].color)
				.onTapGesture {
					tetrisGame.squareClicked(row: row, column: column)
				}
			}
		}

	}
}

struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}
