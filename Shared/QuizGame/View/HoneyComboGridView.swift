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

	@State var width: CGFloat = 0

    var body: some View {
		VStack(spacing: -20) {

			ForEach(setupHoneyGrid().indices, id: \.self) { index in
				HStack(spacing: 4) {
					ForEach(setupHoneyGrid()[index].indices, id: \.self) { subIndex in
						content(setupHoneyGrid()[index][subIndex])
							.frame(width: width / 4)
					}
				}
			}

		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.coordinateSpace(name: "HoneyCombo")
		.overlay {
			GeometryReader { proxy in
				Color.clear
					.preference(
						key: WidthKey.self,
						value: proxy.frame(in: .named("HoneyCombo")).width - proxy.frame(in: .named("HoneyCombo")).minX
					)
					.onPreferenceChange(WidthKey.self) { width in
						self.width = width
					}
			}
		}
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

			if count == items.count {
				if let last = rows.last {

					if rows.count >= 2 {
						let previos = rows[rows.count - 2].count == 4 ? 3 : 4

						if last.count + itemsAtRow.count <= previos {
							rows[rows.count - 1].append(contentsOf: itemsAtRow)
							itemsAtRow.removeAll()
						} else {
							rows.append(itemsAtRow)
							itemsAtRow.removeAll()
						}

					} else {

						if last.count + itemsAtRow.count <= 4 {
							rows[rows.count - 1].append(contentsOf: itemsAtRow)
							itemsAtRow.removeAll()
						} else {
							rows.append(itemsAtRow)
							itemsAtRow.removeAll()
						}

					}

				} else {
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

struct WidthKey: PreferenceKey {
	static var defaultValue: CGFloat = 0

	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}
}
