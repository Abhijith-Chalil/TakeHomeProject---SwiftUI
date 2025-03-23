//
//  UsersResponse.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 15/03/25.
//

import Foundation


// MARK: - UsersResponse
struct UsersResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support

    
}


