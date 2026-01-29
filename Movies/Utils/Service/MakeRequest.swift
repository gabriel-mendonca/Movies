//
//  MakeRequest.swift
//  Movies
//
//  Created by Gabriel Mendonca Sousa Goncalves on 29/01/26.
//  Copyright © 2026 Gabriel Mendonça. All rights reserved.
//

import UIKit

class ApiClient {
    
    static func makeRequest(
        path: String,
        queryItems: [URLQueryItem] = []
    ) -> URLRequest? {

        var components = URLComponents(string: AppConstants.Service.baseURL + path)
        components?.queryItems = queryItems

        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(
            "Bearer \(AppConstants.Service.authToken)",
            forHTTPHeaderField: "Authorization"
        )

        return request
    }

}
