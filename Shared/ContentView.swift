//
//  ContentView.swift
//  Shared
//
//  Created by Mark Nagibin on 19.02.2022.
//

import SwiftUI

struct ContentView: View {

	@State var selection: Int? = nil

    var body: some View {
		NavigationView {
			VStack {
				NavigationLink(tag: 1, selection: $selection) {
					QuizGameHome()
						.navigationBarTitle("")
						.navigationBarHidden(true)
				} label: {
					Button {
						self.selection = 1
					} label: {
						HStack {
							Spacer()
							Text("Go To Quiz Game")
								.foregroundColor(Color.white)
								.bold()
							Spacer()
						}
					}
					.accentColor(Color.black)
					.padding()
					.background(Color.orange)
					.cornerRadius(15)
					.padding(Edge.Set.vertical, 20)
				}
			}
			.padding()
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
			.navigationTitle("SwiftUIProjects")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
