//
//  ConfirmationSheet.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//

import SwiftUI

struct ConfirmationSheet: View {
    @Environment(\.dismiss) private var dismiss
    var item: LargeCardModel
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            // Header with close button
            HStack {
                Text("App Store")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .imageScale(.small)
                        .foregroundStyle(Color(.gray).opacity(0.8), Color(.white).opacity(0.2))
                }
            }
            
            VStack(spacing: 10) {
                HStack {
                    // App Icon
                    Image(item.appLogo)
                        .resizable()
                        .scaledToFit()
                        .background(Color(.lightGray))
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(item.appName)
                                .font(.headline)
                            
                            Text(item.ageRequirement)
                                .font(.footnote)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .foregroundColor(.gray)
                                .background{
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.gray, lineWidth: 1)
                                }
                        }
                        Text(item.appCompany)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Offers In-App Purchases")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                Divider()
                // Account Info
                HStack {
                    Text("Account: ")
                    Text("nishantminerva@icloud.com")
                    Spacer()
                }
                .foregroundColor(.gray)
                .font(.footnote)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemGray5))
            }

            // Bottom
            Button {
                dismiss()
                action()
            } label: {
                VStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .stroke(Color.blue, lineWidth: 3)
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: "button.horizontal.top.press.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    }
                    
                    Text("Confirm by tapping me")
                        .font(.caption)
                        .foregroundStyle(.white)
                }
            }
            .padding(.vertical)
        }
        .padding()
    }
}

//#Preview {
//    ConfirmationSheet()
//}
