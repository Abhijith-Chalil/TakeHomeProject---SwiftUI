//
//  DetailsViewModel.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 21/03/25.
//

import Foundation


final class DetailsViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    @Published private(set) var isLoading = false
    
    @MainActor
    func fetchDetails(for id: Int) async {
        isLoading = true
        defer { isLoading = false}
        
        do {
            let response = try await NetworkingManager.shared.request(.detail(id: id), type: UserDetailResponse.self)
            self.userInfo = response
        } catch {
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.hasError = true
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}
