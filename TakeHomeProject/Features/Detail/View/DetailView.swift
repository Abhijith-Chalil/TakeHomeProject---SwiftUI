//
//  DetailView.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 16/03/25.
//

import SwiftUI

struct DetailView: View {
    
    let userId: Int
    @StateObject private var vm = DetailsViewModel()
    
    
    var body: some View {
        
        ZStack {
            Theme.background.ignoresSafeArea(edges: .top)
            
            if(vm.isLoading) {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        avatar
                        Group {
                            general
                            link
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 18)
                        .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .padding()
                }
                
            }
        }.navigationTitle("Details")
            .task{
                await vm.fetchDetails(for: userId)
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchDetails(for: userId)
                    }
                }}
    }
}

#Preview {
    NavigationStack {
        DetailView(userId: 0)
    }
}


private extension DetailView {
    
    //    @ViewBuilder // using for to say return one or more views
    var general: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            PillView(id: vm.userInfo?.data.id ?? 0)
            Group {
                firstName
                lasttName
                email
            }
            .foregroundColor(Theme.text)
        }
        
        
    }
    
    @ViewBuilder // using for to say return one or more views
    var firstName: some View {
        Text("First Name")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
        Text("\(vm.userInfo?.data.firstName ?? "")")
            .font(.system(.subheadline, design: .rounded))
        Divider()
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarAbsoluteString = vm.userInfo?.data.avatar,
           let avatarUrl = URL(string: avatarAbsoluteString) {
            AsyncImage(url: avatarUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            
        }
    }
    
    @ViewBuilder
    var link: some View {
        
        if let supportAbsoluteString = vm.userInfo?.support.url,
           let supportUrl = URL(string: supportAbsoluteString),
           let supportText = vm.userInfo?.support.text {
            Link(destination: supportUrl){
                VStack(alignment: .leading, spacing: 8) {
                    Text(supportText)
                        .foregroundColor(Theme.text)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
                    Text(supportAbsoluteString)
                }
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                Spacer()
                Symbols.link.font(.system(.title3,design: .rounded))
            }
        }
        
        
    }
    
    @ViewBuilder // using for to say return one or more views
    var lasttName: some View {
        Text("Last Name")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
        Text("\(vm.userInfo?.data.lastName ?? "")")
            .font(.system(.subheadline, design: .rounded))
        Divider()
    }
    
    @ViewBuilder // using for to say return one or more views
    var email: some View {
        Text("Email")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
        Text("\(vm.userInfo?.data.email ?? "")")
            .font(.system(.subheadline, design: .rounded))
    }
}
