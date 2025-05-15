//
//  DIContainer+Welcome.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI
import SwiftData

extension DIContainer {
    @MainActor
    static func makeWelcomeView(context: ModelContext) -> some View {
        let remote = UserRemoteDataSourceImpl.shared
        let local = UserLocalDataSourceSwiftData(context: context)
        let repository = UserRepositoryImpl(remote: remote, local: local)
        let saveUserUseCase = SaveUserUseCase(repository: repository)
        let viewModel = WelcomeViewModel(saveUserUseCase: saveUserUseCase)
        return WelcomeView(viewModel: viewModel)
    }
}
