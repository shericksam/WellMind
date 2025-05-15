//
//  WelcomeView.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import Lottie

struct WelcomeView: View {
    @AppStorage("hasSeenWelcome") var hasSeenWelcome: Bool = false
    @StateObject var viewModel: WelcomeViewModel
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 180))
    ]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.teal]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Spacer()
                if viewModel.selectedSegment != .onSave {
                    Text("welcome_WellMind")
                        .font(.title)
                        .bold()
                    
                    Text("welcome_subtitle")
                        .font(.subheadline)
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
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .stroke(Color.white, lineWidth: 1.5)
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
                        .foregroundColor(viewModel.selectedSegment == .goals && !viewModel.isAllValid && viewModel.formSubmitted ? .gray : .primaryColor)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 14)
                        .background(
                            viewModel.selectedSegment == .goals && !viewModel.isAllValid && viewModel.formSubmitted
                            ? Color.white.opacity(0.5)
                            : Color.white
                        )
                        .clipShape(Capsule())
                        .shadow(color: Color.primaryColor.opacity(0.3), radius: 4, x: 0, y: 2)
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
                    .titleColor(.gray)
                    .selectedLineColor(.gray)
                    .selectedTextColor(.primary)
                    .selectedTitleColor(.primary)
                if let error = viewModel.nameError {
                    HStack {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
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
                            .foregroundColor(.gray)
                        
                        DatePicker("", selection: $viewModel.newUser.birthday, displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(.compact)
                            .accentColor(.primary)
                        if let error = viewModel.birthdayError {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
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
                        .foregroundColor(.gray)
                    
                    Picker("", selection: $viewModel.newUser.gender) {
                        ForEach(Gender.allCases) { gender in
                            Text(gender.rawValue.capitalized).tag(gender)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                if let error = viewModel.genderError {
                    HStack {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
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
            Text("main-goals")
                .font(.title3)
                .bold()
            LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                ForEach(WellnessGoal.allCases) { goal in
                    GoalItemView(
                        goal: goal,
                        isSelected: viewModel.isGoalSelected(goal),
                        onTap: { viewModel.ontapGoal(goal) }
                    )
                }
            }
            if let error = viewModel.goalsError {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    @ViewBuilder
    var onSaveView: some View {
        VStack {
            ZStack {
                LottieView(animation: .named("loading2"))
                    .playbackMode(.playing(.fromProgress(0, toProgress: 1, loopMode: .loop)))
                    .frame(width: 200, height: 200)
                
                Image(.logo)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
            }
            Text("welcome_journey")
                .font(.title)
                .bold()
            
            LottieView(animation: .named("dots"))
                .playbackMode(.playing(.fromProgress(0, toProgress: 1, loopMode: .loop)))
                .frame(height: 200)
        }
    }
}

#Preview {
    DIContainer.makeWelcomeView()
}
