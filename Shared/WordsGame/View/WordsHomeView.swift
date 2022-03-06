//
//  WordsHomeView.swift
//  SwiftUIProjects (iOS)
//
//  Created by 19486464 on 06.03.2022.
//

import SwiftUI

struct WordsHomeView: View {

	@State var bigWord = ""
	@State var player1 = ""
	@State var player2 = ""

    var body: some View {
		VStack {
			Spacer()
			titleText("Words Game")
			wordTextField(text: $bigWord, placeholder: "Input big word")
				.padding(20)
				.padding(.top, 32)
			wordTextField(text: $player1, placeholder: "Player 1")
				.cornerRadius(12)
				.padding(.horizontal, 20)
			wordTextField(text: $player2, placeholder: "Player 2")
				.cornerRadius(12)
				.padding(.horizontal, 20)

			Button {

			} label: {
				Text("Start")
					.font(.custom("AvenirNext-Bold", size: 42))
					.foregroundColor(.white)
					.padding()
					.padding(.horizontal, 64)
					.background(.red)
					.cornerRadius(100)
					.padding(.top)
			}
			Spacer()
		}
		.background(.red.opacity(0.2))
    }


}

private extension WordsHomeView {

	@ViewBuilder
	func titleText(_ text: String) -> some View {
		Text(text)
			.padding()
			.font(.custom("AvenirNext-Bold", size: 42))
			.cornerRadius(16)
			.frame(maxWidth: .infinity)
			.background(Color.red.opacity(0.7))
			.foregroundColor(.white)
	}

	@ViewBuilder
	func wordTextField(text: Binding<String>, placeholder: String) -> some View {
		TextField(placeholder, text: text)
			.font(.title2)
			.padding()
			.background(.white)
			.cornerRadius(12)
	}

}

struct WordsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WordsHomeView()
    }
}
