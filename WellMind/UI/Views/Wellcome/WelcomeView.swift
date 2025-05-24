//
//  WelcomeView.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import Lottie
import SwiftUI

struct WelcomeView: View {
    @AppStorage("hasSeenWelcome") var hasSeenWelcome: Bool = false
    @StateObject var viewModel: WelcomeViewModel
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 130))
    ]

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack {
                Spacer()
                ZStack {
                    LottieView(animation: .named("loading2"))
                            .playbackMode(.playing(.fromProgress(0, toProgress: 1, loopMode: .loop)))
                            .frame(width: 200, height: 200)
                            .scaleEffect(isSaving ? 1.0 : 0.5)
                            .opacity(isSaving ? 1.0 : 0.0)
                            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isSaving)
                            .isHidden(!isSaving)
                    
                    Image(.logo)
                        .resizable()
                        .frame(width: logoSize, height: logoSize)
                        .scaledToFit()
                        .animation(.easeInOut(duration: 0.3), value: viewModel.selectedSegment == .onSave)
                }

                if viewModel.selectedSegment != .onSave {
                    Text("welcome_WellMind")
                        .font(.title)
                        .bold()
                        .foregroundColor(AppColors.primary)

                    Text("welcome_subtitle")
                        .font(.subheadline)
                        .foregroundColor(AppColors.primary.opacity(0.8))

                    Spacer()
                }

                VStack {
                    switch viewModel.selectedSegment {
                    case .form:
                        userInitForm
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    case .goals:
                        goalsView
                            .transition(.move(edge: .leading).combined(with: .opacity))
                    case .onSave:
                        onSaveView
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: viewModel.selectedSegment)
                .disabled(viewModel.selectedSegment == .onSave)
                .padding()
                
                Spacer()
                controls
                Spacer()
            }
            .multilineTextAlignment(.center)
        }
        .navigationTitle("welcome")
    }

    @ViewBuilder
    var controls: some View {
        HStack(spacing: 16) {
            if viewModel.selectedSegment == .goals {
                Button(action: {
                    withAnimation {
                        viewModel.changeSection(.previous)
                    }
                }) {
                    Text("previous".localized)
                        .fontWeight(.medium)
                        .foregroundColor(AppColors.primaryContainer)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .stroke(AppColors.primaryContainer, lineWidth: 1.5)
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }

            if viewModel.selectedSegment != .onSave {
                Button(action: {
                    withAnimation {
                        if viewModel.selectedSegment == .goals {
                            if viewModel.validateAllFields() {
                                viewModel.startSaving()
                            }
                        } else {
                            viewModel.changeSection(.next)
                        }
                    }
                }) {
                    Text(viewModel.selectedSegment == .goals ? "start".localized : "continue".localized)
                        .fontWeight(.semibold)
                        .foregroundColor(
                            viewModel.selectedSegment == .goals && !viewModel.isAllValid && viewModel.formSubmitted
                            ? AppColors.onSurfaceVariant
                            : AppColors.primary
                        )
                        .padding(.horizontal, 28)
                        .padding(.vertical, 14)
                        .background(
                            viewModel.selectedSegment == .goals && !viewModel.isAllValid && viewModel.formSubmitted
                            ? AppColors.surface.opacity(0.5)
                            : AppColors.surface
                        )
                        .clipShape(Capsule())
                        .shadow(color: AppColors.primary.opacity(0.3), radius: 2, x: 0, y: 2)
                }
                .disabled(viewModel.selectedSegment == .goals && viewModel.formSubmitted && !viewModel.isAllValid)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    var userInitForm: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(spacing: 5) {
                FloatingLabelTextField($viewModel.newUser.name, placeholder: "user_name".localized)
                    .titleColor(AppColors.outline)
                    .selectedLineColor(AppColors.outline)
                    .selectedTextColor(AppColors.onSurface)
                    .selectedTitleColor(AppColors.onSurface)
                    .tint(AppColors.primary)

                if let error = viewModel.nameError {
                    HStack {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(AppColors.error)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }

            VStack(spacing: 5) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("user_birthday".localized)
                            .font(.subheadline)
                            .foregroundColor(AppColors.outline)

                        DatePicker("", selection: $viewModel.newUser.birthday, displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(.compact)
                            .accentColor(AppColors.primary)
                            .tint(AppColors.primary)

                        if let error = viewModel.birthdayError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(AppColors.error)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    Spacer()
                }
            }

            VStack(spacing: 5) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("user_gender".localized)
                        .font(.subheadline)
                        .foregroundColor(AppColors.outline)

                    Picker("", selection: $viewModel.newUser.gender) {
                        ForEach(Gender.allCases) { gender in
                            Text(gender.rawValue.capitalized).tag(gender)
                        }
                    }
                    .pickerStyle(.segmented)
                    .tint(AppColors.primary)
                }

                if let error = viewModel.genderError {
                    HStack {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(AppColors.error)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    var goalsView: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("main_goals")
                .font(.title3)
                .bold()
                .foregroundColor(AppColors.onBackground)
            ScrollView {
                LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                    ForEach(WellnessGoal.allCases) { goal in
                        GoalItemView(
                            goal: goal,
                            isSelected: viewModel.isGoalSelected(goal),
                            onTap: { viewModel.ontapGoal(goal) }
                        )
                    }
                }
            }
            if let error = viewModel.goalsError {
                Text(error)
                    .font(.caption)
                    .foregroundColor(AppColors.error)
                    .multilineTextAlignment(.center)
            }
        }
    }

    @ViewBuilder
    var onSaveView: some View {
        VStack {
            Text("welcome_journey")
                .font(.title)
                .bold()
                .foregroundColor(AppColors.primary)

            LottieView(animation: .named("dots"))
                .playbackMode(.playing(.fromProgress(0, toProgress: 1, loopMode: .loop)))
                .frame(height: 200)
        }
    }
    
    var logoSize: CGFloat {
        viewModel.selectedSegment == .onSave ? 200 : 100
    }
    
    var isSaving: Bool {
        viewModel.selectedSegment == .onSave
    }
}

#Preview {
    let preview = Preview()
    DIContainer.makeWelcomeView(context: preview.modelContainer.mainContext)
}
