//
//  CheckmarkPopOverview.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 22/03/25.
//

import SwiftUI

struct CheckmarkPopOverview: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle, design: .rounded)).bold().padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    CheckmarkPopOverview()
}
