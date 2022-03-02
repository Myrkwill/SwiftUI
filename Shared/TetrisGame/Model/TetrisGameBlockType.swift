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

	var shadow: Color {
		switch self {
		case .i: return .tetrisLightBlueShadow
		case .t: return .tetrisDarkBlueShadow
		case .o: return .tetrisOrangeShadow
		case .j: return .tetrisYellowShadow
		case .l: return .tetrisGreenShadow
		case .s: return .tetrisPurpleShadow
		case .z: return .tetrisRedShadow
		}
	}
}
