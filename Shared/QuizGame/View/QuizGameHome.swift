//
//  QuizGameHome.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 19.02.2022.
//

import SwiftUI
import SPSafeSymbols

struct QuizGameHome: View {

	// MARK: - Текущий пазл
	@State var currentPuzzle: QuizGamePuzzle = puzzles[0]

	var body: some View {
		VStack {

			VStack {
				HStack {

					/// Кнопка
					Button {

					} label: {
						Image(.arrowtriangle.backwardSquareFill)
							.font(.title)
							.foregroundColor(.black)
					}

					Spacer()

					/// Кнопка громкости
					Button {

					} label: {
						Image(.speaker.wave_2Fill)
							.font(.title3)
							.padding(10)
							.background(Color.deepSkyBlue, in: Circle())
							.foregroundColor(.white)
					}
				}
				.overlay {
					Text("Level 1")
						.fontWeight(.bold)
				}

				// MARK: - Puzzle Image
				Image(currentPuzzle.imageName)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(height: 200)
					.padding(.top)

			}
			.padding()
			.background(.white, in: RoundedRectangle(cornerRadius: 15))
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.background(Color.blue)
	}
}

struct QuizGameHome_Previews: PreviewProvider {
	static var previews: some View {
		QuizGameHome()
	}
}

