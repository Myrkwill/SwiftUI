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
				naviagtionButtonLink(for: .qiuz)
				naviagtionButtonLink(for: .tetris)
			}
			.padding()
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
			.navigationTitle("SwiftUIProjects")
		}
    }

	func naviagtionButtonLink(for project: Project) -> some View {
		NavigationLink(tag: project.rawValue, selection: $selection) {
			project.view
		} label: {
			Button {
				self.selection = project.rawValue
			} label: {
				HStack {
					Spacer()
					Text(project.title)
						.foregroundColor(Color.white)
						.bold()
					Spacer()
				}
			}
			.padding()
			.background(project.backgroundColor)
			.cornerRadius(15)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
