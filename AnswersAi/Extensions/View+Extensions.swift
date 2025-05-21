//
//  View+Extensions.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//

import SwiftUI

extension View {
    func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared
            .connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }

        return safeArea
    }
}
