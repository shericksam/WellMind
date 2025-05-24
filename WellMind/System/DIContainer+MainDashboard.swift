//
//  DIContainer+MainDashboard.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI
import SwiftData

extension DIContainer {
    @MainActor
    static func makeMainDashboardView(context: ModelContext) -> some View {
        let remote = UserRemoteDataSourceImpl.shared
        let local = UserLocalDataSourceSwiftData(context: context)
        let repository = UserRepositoryImpl(remote: remote, local: local)
        let getUserUseCase = GetUserUseCase(repository: repository)
        let healthManager = HealthManager()
        
        let viewModel = MainDashboardViewModel(getUserUseCase: getUserUseCase, healthManager: healthManager)
        return MainDashboardView(viewModel: viewModel)
    }
}
