//
//  CreateView.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 17/03/25.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = CreateViewModel()
    let successfulAction: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                firstName
                lastName
                job
                Section {
                    submit
                }
            }
            .disabled(vm.state == .submitting)
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
            .onChange(of: vm.state) { oldValue, formState in
                if formState == .successful {
                    dismiss()
                    successfulAction()
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Ok") {
                }
            }
            .overlay {
                
                if(vm.state == .submitting) {
                    ProgressView()
                }
                
            }
        }
    }
}

#Preview {
    CreateView {}
}

private extension CreateView {
    var firstName: some View {
        TextField("First Name", text: $vm.person.firstName)
    }
    
    var lastName: some View {
        TextField("Last Name", text: $vm.person.lastName)
    }
    
    var job: some View {
        TextField("Job", text: $vm.person.job)
    }
    
    var submit: some View {
        Button("Submit") {
            vm.create()
        }
    }
    
    var done: some View {
        Button("Done") {
            dismiss()
        }
    }
}
