//
//  TodayViewModel.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//

import Foundation

@MainActor
class TodayViewModel: ObservableObject {
    @Published var todayItems: [LargeCardModel] = []
    @Published var moreStories: [LargeCardModel] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    enum TodayViewError: LocalizedError {
        case fileNotFound
        case decodingError
        
        var errorDescription: String? {
            switch self {
            case .fileNotFound:
                return "Unable to locate the JSON file"
            case .decodingError:
                return "Error occurred while decoding the JSON data"
            }
        }
    }
    
    func loadContent() {
        Task {
            do {
                isLoading = true
                // Load today items
                self.todayItems = try await loadJSON(from: "today")
                // Load more stories
                self.moreStories = try await loadJSON(from: "memories")
                isLoading = false
            } catch {
                self.error = error
                isLoading = false
            }
        }
    }
    
    private func loadJSON(from filename: String) async throws -> [LargeCardModel] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw TodayViewError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([LargeCardModel].self, from: data)
        } catch {
            throw TodayViewError.decodingError
        }
    }
}
