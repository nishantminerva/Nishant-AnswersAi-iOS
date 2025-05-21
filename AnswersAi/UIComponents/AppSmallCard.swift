//
//  AppSmallCard.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//


import SwiftUI

struct AppSmallCard: View {
    var item: LargeCardModel
	var titleColor: Color = .primary
	var subtitleColor: Color = .secondary
	var buttonDescriptionColor: Color = .primary
	var imageSize: CGFloat = 60
	
	var body: some View {
		HStack {
            Image(item.appLogo)
				.resizable()
				.scaledToFit()
				.background(Color(.lightGray))
				.frame(width: imageSize, height: imageSize)
				.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
			
			VStack(alignment: .leading) {
                Text(item.appName)
					.bold()
					.foregroundColor(titleColor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Text(item.appDescription)
					.font(.subheadline)
					.foregroundColor(subtitleColor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
			}
			
			Spacer()
			
			VStack {
                GetButton(item: item)
					.padding(.bottom, 8)
				
				InAppPurchasesLabel(titleColor: buttonDescriptionColor)
			}
		}
	}
}


//#Preview {
//    AppSmallCard()
//        .padding()
//}
