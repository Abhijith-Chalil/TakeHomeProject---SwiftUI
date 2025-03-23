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
    
    func fetchDetails(for id: Int) {
        isLoading = true
        NetworkingManager.shared.request("https://reqres.in/api/users/\(id)?delay=3", type: UserDetailResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                defer {self?.isLoading = false }
                switch res {
                case .success(let response):
                    self?.userInfo = response
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                    
                }
            }
            
        }
    }
}
