//
//  View+Navigation.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 29/03/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func embedInNavigation() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                self
            }
        } else {
            NavigationView {
                self
            }
        }
    }
}


