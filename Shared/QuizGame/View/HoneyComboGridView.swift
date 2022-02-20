//
//  HoneyComboGridView.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 20.02.2022.
//

import SwiftUI

struct HoneyComboGridView<Content: View, Item>: View where Item: RandomAccessCollection {

	var content: (Item.Element) -> Content
	var items: Item

	init(items: Item, @ViewBuilder content: @escaping (Item.Element) -> Content) {
		self.content = content
		self.items = items
	}

    var body: some View {
		VStack {

			ForEach(setupHoneyGrid().indices, id: \.self) { index in
				HStack(spacing: 4) {
					ForEach(setupHoneyGrid()[index].indices, id: \.self) { subIndex in
						content(setupHoneyGrid()[index][subIndex])
					}
				}
			}

		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

	func setupHoneyGrid() -> [[Item.Element]] {
		var rows: [[Item.Element]] = []
		var itemsAtRow: [Item.Element] = []

		var count = 0

		items.forEach { item in
			itemsAtRow.append(item)
			count += 1


			if itemsAtRow.count >= 3 {
				if rows.isEmpty && itemsAtRow.count == 4 {
					rows.append(itemsAtRow)
					itemsAtRow.removeAll()
				} else if let last = rows.last, last.count == 4 && itemsAtRow.count == 3 {
					rows.append(itemsAtRow)
					itemsAtRow.removeAll()
				} else if let last = rows.last, last.count == 3 && itemsAtRow.count == 4 {
					rows.append(itemsAtRow)
					itemsAtRow.removeAll()
				}
			}
		}

		return rows
	}
}

struct HoneyComboGridView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
