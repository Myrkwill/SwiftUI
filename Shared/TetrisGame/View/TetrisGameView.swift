//
//  TetrisGameView.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import SwiftUI
import SPSafeSymbols

struct TetrisGameView: View {

	@Environment(\.presentationMode) var presentationMode

	@ObservedObject var tetrisGame = TetrisGameViewModel()

	@State var pauseGame: Bool = false
	@State var startGame: Bool = true

    var body: some View {
		VStack(alignment: .leading) {
			menu()

			if !startGame {
				GeometryReader { proxy in
					drawBoard(rect: proxy.size)
				}
				.gesture(tetrisGame.moveGesture())
				.gesture(tetrisGame.rotateGesture())
			}
		}
		.padding()
		.background(Color.gray)
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
					let y = rect.height - yOffset - blockSize * CGFloat(row + 1)
					let pathRect = CGRect(x: x, y: y, width: blockSize, height: blockSize)
					path.addRect(pathRect)
				}
				.fill(tetrisGame.board[column][row].color)
			}
		}
	}

	func menu() -> some View {
		VStack {
			HStack(spacing: 10) {

				backButton()
				Spacer()

				if pauseGame {
					restartButton()
					playButton()
				}

				if !pauseGame && !startGame {
					stopButton()
				}

			}
			.overlay {
				Text("Tetris Game")
					.fontWeight(.bold)
			}

			if startGame {
				Spacer()
				VStack {
					Text("Press to start the game")
						.fontWeight(.black)
						.font(.largeTitle)
						.foregroundColor(.black)
						.multilineTextAlignment(.center)
					bigPlayButton()
				}
				Spacer()
			}
		}
		.padding()
		.background(.white, in: RoundedRectangle(cornerRadius: 15))
	}

}

extension TetrisGameView {

	func bigPlayButton() -> some View {
		Button {
			withAnimation {
				tetrisGame.startGame()
				startGame.toggle()
			}
		} label: {
			Image(.play.circleFill)
				.resizable()
				.frame(width: 100, height: 100)
				.foregroundColor(.yellow)
		}

	}

	func playButton() -> some View {
		Button {
			withAnimation {
				pauseGame.toggle()
				tetrisGame.startGame()
			}
		} label: {
			Image(.play.rectangleFill)
				.font(.title)
				.foregroundColor(.yellow)
		}
	}

	func restartButton() -> some View {
		Button {
			withAnimation {
				tetrisGame.restartGame()
				pauseGame.toggle()
			}
		} label: {
			Image(.gobackward)
				.font(.title)
				.foregroundColor(.yellow)
		}
	}

	func stopButton() -> some View {
		Button {
			withAnimation {
				tetrisGame.pauseGame()
				pauseGame.toggle()
			}
		} label: {
			Image(.pause.rectangleFill)
				.font(.title)
				.foregroundColor(.yellow)
		}
	}

	func backButton() -> some View {
		Button {
			presentationMode.wrappedValue.dismiss()
		} label: {
			Image(.arrowtriangle.backwardSquareFill)
				.font(.title)
				.foregroundColor(.yellow)
		}
	}

}

struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}
