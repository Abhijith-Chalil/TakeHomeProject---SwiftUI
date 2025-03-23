//
//  PeopleView.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 16/03/25.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject private var vm = PeopleViewModel()
    
    //    @State private var users: [User] = []
    @State private var shouldShowCreate = false
    @State private var shouldShowSuccess = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background
                    .ignoresSafeArea(edges: .top)
                
                if(vm.isLoading) {
                    ProgressView()
                } else {
                    
                    ScrollView {
                        LazyVGrid(columns: columns,spacing: 16) {
                            ForEach(vm.users, id:\.id) { user in
                                NavigationLink {
                                    DetailView(userId: user.id)
                                } label: {
                                    PersonItemView(user: user)
                                }
                                
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        shouldShowCreate.toggle()
                    } label: {
                        Symbols.plus.font(.system(.headline,design: .rounded)).bold()
                    }
                    .disabled(vm.isLoading)
                }
            }
            .onAppear{
                vm.fetchUsers()
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView {
                    withAnimation(.spring().delay(0.25)) {
                        shouldShowSuccess = true
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    vm.fetchUsers()
                }
            }
            .overlay {
                if shouldShowSuccess {
                    CheckmarkPopOverview()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.shouldShowSuccess.toggle()
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    PeopleView()
}
