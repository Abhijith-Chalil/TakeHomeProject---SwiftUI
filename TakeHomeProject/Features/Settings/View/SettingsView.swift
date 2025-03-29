//
//  SettingsView.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 26/03/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled: Bool = false
    var body: some View {
        
        Form {
            haptics
        } .embedInNavigation()
        
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
    }
}

#Preview {
    SettingsView()
}
