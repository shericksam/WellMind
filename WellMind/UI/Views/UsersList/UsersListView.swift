//
//  UsersListView.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI
import SwiftData

struct UsersListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: UsersListViewModel
    @State private var newName: String = "name"
    @State private var newEmail: String = "mail@mail.com"

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name).font(.headline)
                        Text(user.email).font(.subheadline).foregroundColor(.gray)
                    }
                }
                .onDelete { offsets in
                    Task {
                        await viewModel.deleteUser(at: offsets)
                    }
                }
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        Task {
                            await viewModel.addUser(name: newName, email: newEmail)
                            newName = ""
                            newEmail = ""
                        }
                    }) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .task {
                await viewModel.loadUsers()
            }

            VStack {
                TextField("Name", text: $newName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                TextField("Email", text: $newEmail)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            .padding()
            .card()
        }
    }
}
