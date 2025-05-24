//
//  HealthManager.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 15/05/25.
//

import HealthKit
import Foundation
import HealthKit

class HealthManager: ObservableObject {
    private let store = HKHealthStore()

    @Published var stepCount: Double = 0
    @Published var sleepHours: Double = 0

    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else { return }

        let readTypes: Set = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]

        store.requestAuthorization(toShare: [], read: readTypes) { success, error in
            if success {
                self.fetchStepCount()
                self.fetchSleepAnalysis()
            } else {
                print("❌ Error autorizando HealthKit: \(error?.localizedDescription ?? "Desconocido")")
            }
        }
    }

    func fetchStepCount() {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }

        let start = Calendar.current.startOfDay(for: Date())
        let end = Date()
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)

        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
            _, result, _ in
            DispatchQueue.main.async {
                if let sum = result?.sumQuantity() {
                    self.stepCount = sum.doubleValue(for: HKUnit.count())
                }
            }
        }
        store.execute(query)
    }

    func fetchSleepAnalysis() {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return }

        let start = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let end = Date()
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)

        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {
            _, samples, _ in
            var total: TimeInterval = 0
            for sample in samples as? [HKCategorySample] ?? [] {
                if sample.value == HKCategoryValueSleepAnalysis.asleepUnspecified.rawValue {
                    total += sample.endDate.timeIntervalSince(sample.startDate)
                }
            }
            DispatchQueue.main.async {
                self.sleepHours = total / 3600.0 // en horas
            }
        }
        store.execute(query)
    }
}
