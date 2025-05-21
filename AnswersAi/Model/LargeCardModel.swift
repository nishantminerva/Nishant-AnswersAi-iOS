//
//  LargeCardModel.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//

import Foundation

struct LargeCardModel: Identifiable, Codable {
    var id: String
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var platformSubTitle: String?
    var artwork: String
    var placeholderText: String
    var ageRequirement: String
    var appCompany: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        appName = try container.decode(String.self, forKey: .appName)
        appDescription = try container.decode(String.self, forKey: .appDescription)
        appLogo = try container.decode(String.self, forKey: .appLogo)
        bannerTitle = try container.decode(String.self, forKey: .bannerTitle)
        platformTitle = try container.decode(String.self, forKey: .platformTitle)
        platformSubTitle = try container.decodeIfPresent(String.self, forKey: .platformSubTitle)
        artwork = try container.decode(String.self, forKey: .artwork)
        placeholderText = try container.decode(String.self, forKey: .placeholderText)
        ageRequirement = try container.decode(String.self, forKey: .ageRequirement)
        appCompany = try container.decode(String.self, forKey: .appCompany)
    }
}
