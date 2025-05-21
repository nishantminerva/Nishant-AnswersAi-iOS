//
//  InAppPurchasesLabel.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//


import SwiftUI

struct InAppPurchasesLabel: View {
	var title: String = "In-App Purchases"
	var titleColor: Color = .primary

	var body: some View {
		Text(title)
			.font(.system(size: 8))
			.foregroundColor(titleColor)
	}
}


#Preview {
    InAppPurchasesLabel()
}
