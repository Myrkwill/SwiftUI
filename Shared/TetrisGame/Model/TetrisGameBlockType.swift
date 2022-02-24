//
//  TetrisGameBlockType.swift
//  SwiftUIProjects
//
//  Created by Mark Nagibin on 23.02.2022.
//

import Foundation
import SwiftUI

enum TetrisGameBlockType: CaseIterable {
	case i, t, o, j, l, s, z

	var color: Color {
		switch self {
		case .i: return .tetrisLightBlue
		case .t: return .tetrisDarkBlue
		case .o: return .tetrisOrange
		case .j: return .tetrisYellow
		case .l: return .tetrisGreen
		case .s: return .tetrisPurple
		case .z: return .tetrisRed
		}
	}
}
