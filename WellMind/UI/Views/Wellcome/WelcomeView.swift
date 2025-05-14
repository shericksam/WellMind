//
//  WelcomeView.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct WelcomeView: View {
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
                Text("welcome_WellMind")
                    .font(.title)
                    .bold()
                Text("welcome_subtitle")
                    .font(.subheadline)
                Spacer()
                VStack {
                    switch viewModel.selectedSegment {
                    case .form:
                        userInitForm
                    case .goals:
                        goalsView
                    }
                }
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

            Button(action: {
                withAnimation {
                    if viewModel.selectedSegment == .goals {
                        // formViewModel.showSaveScreen { ... }
                    } else {
                        viewModel.changeSection(.next)
                    }
                }
            }) {
                Text(viewModel.selectedSegment == .goals ? "start".localized : "continue".localized)
                    .fontWeight(.semibold)
                    .foregroundColor(.primaryColor)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 14)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadow(color: Color.primaryColor.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal)
    }

    
    @ViewBuilder
    var userInitForm: some View {
        VStack(alignment: .leading, spacing: 20) {
            FloatingLabelTextField($viewModel.newUser.name, placeholder: "user_name".localized)
                .titleColor(.gray)
                .selectedLineColor(.gray)
                .selectedTextColor(.primary)
                .selectedTitleColor(.primary)

            VStack(alignment: .leading, spacing: 6) {
                Text("user_birthday".localized)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                DatePicker("", selection: $viewModel.newUser.birthday, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    .accentColor(.primary)
            }

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
        }
    }
}

#Preview {
    DIContainer.makeWelcomeView()
}
//🧭 Etapa 1 – Estructura Base de Pantallas
//📱 1. Pantalla de Onboarding
//Objetivo: Recolectar datos iniciales del usuario.
//Contenido:
//* Título: “Bienvenido a WellMind”
//* Subtítulo: “Crea tu perfil de bienestar para recomendaciones personalizadas”
//* Campos:
//    * Nombre
//    * Edad
//    * Género (Picker)
//    * Objetivo principal (ej: Dormir mejor, Reducir estrés, Mejorar energía)
//* Botón: “Comenzar” (navega a la pantalla principal)
//Estilo sugerido:
//* Fondo: Color blanco o degradado suave (LinearGradient azul a celeste)
//* Botón: Botón grande con fondo AccentColor (ej: Color.teal)
//* Tipografía: Título .title.bold(), subtítulo .subheadline
