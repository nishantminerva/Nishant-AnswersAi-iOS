//
//  SecondaryButton.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//


import SwiftUI

struct SecondaryButton: View {
	@Environment(\.colorScheme) var colorScheme: ColorScheme
	@State var isPresented = false
	let title: String
	var backgroundColor = Color(.tertiarySystemGroupedBackground)
	var systemImageName: String? = nil
	
	var body: some View {
		Button {
            shareModel()
		} label: {
			HStack {
                Image(systemName: systemImageName ?? "")
                Text(title)
			}
            .font(.headline)
            .padding(10)
            .foregroundColor(colorScheme == .light ? .blue : .white)
            .background(backgroundColor)
            .cornerRadius(12)
		}
	}
    
    private func shareModel() {
        let textToShare =
        "Hey check out this amazing app"
        let activityVC = UIActivityViewController(
            activityItems: [textToShare], applicationActivities: nil)
        
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first
                as? UIWindowScene,
               let rootViewController = windowScene.windows.first?
                .rootViewController
            {
                rootViewController.present(
                    activityVC, animated: true, completion: nil)
            }
        }
    }
}


#Preview {
    SecondaryButton(title: "Title")
}
