//
//  MainDashboardView.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 14/05/25.
//

import SwiftUI
import SwiftData

struct MainDashboardView: View {
    @StateObject var viewModel: MainDashboardViewModel
    @Query({
        var desc = FetchDescriptor<UserModel>()
      desc.sortBy = [SortDescriptor(\.timestamp, order: .reverse)]
      desc.fetchLimit = 10
      return desc
    }()) var top10Items: [UserModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("greeting".localized(viewModel.user?.name ?? ""))
                            .font(.largeTitle.bold())
                            .foregroundColor(AppColors.primary)

                        summaryCards

                        VStack(alignment: .leading, spacing: 8) {
                            Text("daily_recommendation")
                                .font(.headline)
                                .foregroundColor(AppColors.primary)

                            Text("recommendation_1")
                                .font(.subheadline)
                                .foregroundColor(AppColors.onBackground)
                                .padding()
                                .background(AppColors.surface)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        actionButtons
                    }
                    .padding()
                }
            }
            .task {
                await viewModel.loadUser()
                viewModel.healthManagerRequestAuthorization()
            }
            .onAppear(perform: {
                print(top10Items)
            })
            .navigationTitle("summary")
        }
    }

    var summaryCards: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            SummaryCard(title: "Estado de ánimo", value: "😊", color: AppColors.secondary)
            SummaryCard(title: "Sueño", value: "\(viewModel.healthManager.sleepHours)", color: AppColors.tertiary)
            SummaryCard(title: "Pasos", value: "\(viewModel.healthManager.stepCount)", color: AppColors.outline)
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
