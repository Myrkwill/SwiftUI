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

	// MARK: -
	@State var selectedLetters: [QuizGameLatter] = []

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
								.fill(Color.deepSkyBlue.opacity(
									selectedLetters.count > index ? 1 : 0.2
								))
								.frame(height: 60)

							if selectedLetters.count > index {
								Text(selectedLetters[index].value)
									.font(.title)
									.fontWeight(.black)
									.foregroundColor(.white)
							}
						}
					}
				}
			}
			.padding()
			.background(.white, in: RoundedRectangle(cornerRadius: 15))

			// MARK: - Custom Honey Combo Grid View
			HoneyComboGridView(items: currentPuzzle.latters) { item in
				ZStack {
					HexagonShape()
						.fill(isSelected(latter: item) ? Color.orange : .white)
						.aspectRatio(contentMode: .fit)
						.shadow(color: .black.opacity(0.1), radius: 5, x: 10, y: 5)
						.shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: 8)

					Text(item.value)
						.font(.largeTitle)
						.fontWeight(.black)
						.foregroundColor(
							isSelected(latter: item) ? .white : .gray.opacity(0.5)
						)
				}
				.contentShape(HexagonShape())
				.onTapGesture {
					addLatter(item)
				}
			}

			// MARK: - Next Button
			Button {
				selectedLetters.removeAll()
				currentPuzzle = puzzles[0]
				generateLatters()
			} label: {
				Text("Next")
					.font(.title3.bold())
					.foregroundColor(.white)
					.padding(.vertical)
					.frame(maxWidth: .infinity)
					.background(Color.orange, in: RoundedRectangle(cornerRadius: 15))
			}
			.disabled(selectedLetters.count != currentPuzzle.answer.count)
			.opacity(selectedLetters.count != currentPuzzle.answer.count ? 0.6 : 1)
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.background(Color.blue)
		.onAppear {
			generateLatters()
		}
	}

	private func addLatter(_ latter: QuizGameLatter) {
		withAnimation {
			if isSelected(latter: latter) {
				selectedLetters.removeAll { $0.id == latter.id }
			} else {
				if selectedLetters.count == currentPuzzle.latters.count { return }
				selectedLetters.append(latter)
			}
		}
	}

	private func isSelected(latter: QuizGameLatter) -> Bool {
		selectedLetters.contains { $0.id == latter.id }
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

