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
					.padding(.vertical)


				// MARK: - Puzzle Fill Blanks
				HStack(spacing: 10) {
					ForEach(0..<currentPuzzle.answer.count, id: \.self) { index in
						ZStack {
							RoundedRectangle(cornerRadius: 10)
								.fill(Color.deepSkyBlue.opacity(0.2))
								.frame(height: 60)
						}
					}
				}
			}
			.padding()
			.background(.white, in: RoundedRectangle(cornerRadius: 15))

			// MARK: - Custom Honey Combo Grid View
			HoneyComboGridView(items: currentPuzzle.latters) { item in
				Text(item.value)
			}

			// MARK: - Next Button
			Button {

			} label: {
				Text("Next")
					.font(.title3.bold())
					.foregroundColor(.white)
					.padding(.vertical)
					.frame(maxWidth: .infinity)
					.background(Color.deepSkyBlue, in: RoundedRectangle(cornerRadius: 15))
			}
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.background(Color.blue)
		.onAppear {
			generateLatters()
		}
	}

	private func generateLatters() {
		currentPuzzle.jumbbledWord.forEach { char in
			let latter = QuizGameLatter(value: String(char))
			currentPuzzle.latters.append(latter)
		}
	}
}

struct QuizGameHome_Previews: PreviewProvider {
	static var previews: some View {
		QuizGameHome()
	}
}

