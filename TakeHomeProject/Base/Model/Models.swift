//
//  Models.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 15/03/25.
//

import Foundation

// MARK: - Userm
struct User: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}
