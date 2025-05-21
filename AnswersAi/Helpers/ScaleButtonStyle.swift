//
//  ScaleButtonStyle.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//


import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
	 func makeBody(configuration: Configuration) -> some View {
		  configuration.label
				.scaleEffect(configuration.isPressed ? 0.96 : 1)
				.animation(.easeInOut, value: configuration.isPressed)
	 }
}

extension ButtonStyle where Self == ScaleButtonStyle {
	static var scaleButtonStyle: ScaleButtonStyle { .init() }
}
