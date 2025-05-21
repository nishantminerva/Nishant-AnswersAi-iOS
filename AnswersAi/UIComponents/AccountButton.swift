//
//  AccountButton.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//


import SwiftUI

struct AccountButton: View {
	@Binding var isAccountViewPresented: Bool
	
	var body: some View {
		Button {
            
		} label: {
			Image(systemName: "person.crop.circle.fill")
				.font(.title)
				.imageScale(.medium)
				.foregroundColor(.secondary)
		}
	}
}


#Preview {
    AccountButton(isAccountViewPresented: .constant(false))
}
