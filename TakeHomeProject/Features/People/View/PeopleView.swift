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
    @State private var viewHasAppeared = false
    
    var body: some View {
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
                                    PersonItemView(user: user).task {
                                        if vm.hasReachedEnd(of: user) && !vm.isFetching {
                                           await vm.fetchNextSetOfUsers()
                                        }
                                    }
                                }
                                
                            }
                        }
                        .padding()
                    }
                    .refreshable(action: {
                       await vm.fetchUsers()
                    })
                    .overlay(alignment: .bottom) {
                        if vm.isFetching {
                            ProgressView()
                        }
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
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        Task {
                            await vm.fetchUsers()
                        }
                    } label: {
                        Symbols.refresh.font(.system(.subheadline,design: .rounded)).bold()
                    }
                    .disabled(vm.isLoading)
                }
            }
            .task{
                if !viewHasAppeared {
                    await vm.fetchUsers()
                    viewHasAppeared = true
                }
                
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        shouldShowSuccess = true
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchUsers()
                    }
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
            .embedInNavigation()
        
    }
}

#Preview {
    PeopleView()
}
