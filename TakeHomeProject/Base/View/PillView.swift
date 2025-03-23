//
//  PillView.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 16/03/25.
//

import SwiftUI

struct PillView: View {
    
    let id: Int
    
    var body: some View {
        Text("#\(id)")
            .font(.system(.caption, design: .rounded))
            .bold()
            .foregroundColor(.white)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Theme.pill,in: Capsule())
    }
}

#Preview {
    PillView(id: 1)
}
