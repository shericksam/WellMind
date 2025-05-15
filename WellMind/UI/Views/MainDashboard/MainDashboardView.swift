//
//  MainDashboardView.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI


struct MainDashboardView: View {
    @StateObject var viewModel: MainDashboardViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Saludo
                        Text("Hola, \(viewModel.user?.name ?? "") 👋")
                            .font(.largeTitle.bold())
                            .foregroundColor(AppColors.primary)

                        // Tarjetas de resumen
                        summaryCards

                        // Recomendación del día
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Recomendación del día")
                                .font(.headline)
                                .foregroundColor(AppColors.primary)

                            Text("Hoy intenta respirar profundo por 1 minuto.")
                                .font(.subheadline)
                                .foregroundColor(AppColors.onBackground)
                                .padding()
                                .background(AppColors.surface)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        // Botones
                        actionButtons
                    }
                    .padding()
                }
            }
            .task {
                await viewModel.loadUser()
            }
            .navigationTitle("Resumen")
        }
    }

    var summaryCards: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            SummaryCard(title: "Estado de ánimo", value: "😊", color: AppColors.secondary)
            SummaryCard(title: "Sueño", value: "7h 45m", color: AppColors.tertiary)
            SummaryCard(title: "Pasos", value: "---", color: AppColors.outline)
        }
    }

    var actionButtons: some View {
        VStack(spacing: 12) {
            NavigationLink(destination: DIContainer.makeDailyEntryView()) {
                Text("Registrar hoy")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.primary)
                    .clipShape(Capsule())
            }

            NavigationLink(destination: ProgressView()) {
                Text("Ver progreso")
                    .fontWeight(.semibold)
                    .foregroundColor(AppColors.primary)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.surface)
                    .overlay(
                        Capsule().stroke(AppColors.primary, lineWidth: 1.5)
                    )
            }

            NavigationLink(destination: DIContainer.makeSettingsView()) {
                Text("Configuración")
                    .fontWeight(.medium)
                    .foregroundColor(AppColors.onBackground)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.surfaceVariant)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}
#Preview {
    let preview = Preview()
    return DIContainer.makeMainDashboardView(context: preview.modelContainer.mainContext)
}
