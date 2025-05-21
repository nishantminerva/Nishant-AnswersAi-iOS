//
//  GetButton.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//


import SwiftUI

struct GetButton: View {
    var item: LargeCardModel
    @State private var isLoading = false
    @State private var progress: CGFloat = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var title: String = "GET"
    @State var presentSheet: Bool = false
    
    var body: some View {
        Button {
            presentSheet = true
        } label: {
            if isLoading {
                CircularProgressView(progress: progress, linewidth: 4)
                    .frame(width: 25, height: 25)
                .onReceive(timer) { _ in
                    updateProgress()
                }
            } else {
                Text(title)
                    .font(Font.system(.caption).bold())
                    .padding(.horizontal, 24)
                    .padding(.vertical, 6)
                    .foregroundStyle(Color.white)
                    .background(.thinMaterial)
                    .clipShape(Capsule())
            }
        }
        .sheet(isPresented: $presentSheet) {
            ConfirmationSheet(item: item, action: {
                startLoading()
            })
            .presentationDetents([.fraction(0.4)])
        }
    }
    
    private func startLoading() {
        isLoading = true
        progress = 0.0
    }
    
    private func updateProgress() {
        if isLoading {
            if progress < 1.0 {
                progress += 0.2 // Increment by 20% each second
            } else {
                isLoading = false
            }
        }
    }
}

//#Preview {
//    GetButton()
//}
