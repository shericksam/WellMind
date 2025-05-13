//
//  DateExtension.swift
//  WellMind
//
//  Created by Erick Samuel Guerrero Arreola on 12/05/25.
//

import Foundation
import Foundation

extension Date {
    func subtracting(days: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: -days, to: self)
    }
    func subtracting(months: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: -months, to: self)
    }
    func subtracting(years: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .year, value: -years, to: self)
    }
    func subtracting(hours: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: -hours, to: self)
    }
    func subtracting(minutes: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: -minutes, to: self)
    }
    func subtracting(seconds: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .second, value: -seconds, to: self)
    }
    func adding(days: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: days, to: self)
    }
    func adding(months: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: months, to: self)
    }
    func adding(years: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .year, value: years, to: self)
    }
    func adding(hours: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: hours, to: self)
    }
    func adding(minutes: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: minutes, to: self)
    }
    func adding(seconds: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .second, value: seconds, to: self)
    }
    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    func isTomorrow() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
    func isYesterday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(self)
    }
    func isInFuture() -> Bool {
        return self > Date()
    }
    func isInPast() -> Bool {
        return self < Date()
    }
    func isInSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
    func isInSameMonth(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .month)
    }
    func isInSameYear(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .year)
    }
    func isInSameHour(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .hour)
    }
    func isInSameMinute(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .minute)
    }
    func isInSameSecond(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .second)
    }
    func isInSameWeek(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    func isInSameWeekday(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .weekday)
    }
    func isInSameQuarter(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .quarter)
    }
    func isInSameTimeZone(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .timeZone)
    }
    func isInSameEra(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .era)
    }
    func isInSameCalendar(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .calendar)
    }
}
