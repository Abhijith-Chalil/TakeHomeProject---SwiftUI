//
//  CreateView.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 17/03/25.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusField: Field?
    @StateObject private var vm = CreateViewModel()
    let successfulAction: () -> Void
    
    var body: some View {
        
        Form {
            Section {
                firstName
                lastName
                job
            } footer: {
                
                if case .validation(let error) = vm.error,
                   let errorDesc = error.errorDescription {
                    Text(errorDesc)
                        .foregroundStyle(.red)
                }
                
            }
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
            
        } .embedInNavigation()
        
    }
}

#Preview {
    CreateView {}
}

private extension CreateView {
    var firstName: some View {
        TextField("First Name", text: $vm.person.firstName)
            .focused($focusField, equals: .firstName)
    }
    
    var lastName: some View {
        TextField("Last Name", text: $vm.person.lastName)
            .focused($focusField, equals: .lastName)
    }
    
    var job: some View {
        TextField("Job", text: $vm.person.job)
            .focused($focusField, equals: .job)
    }
    
    var submit: some View {
        Button("Submit") {
            focusField = nil
            Task {
                await vm.create()
            }
        }
    }
    
    var done: some View {
        Button("Done") {
            dismiss()
        }
    }
}

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}
