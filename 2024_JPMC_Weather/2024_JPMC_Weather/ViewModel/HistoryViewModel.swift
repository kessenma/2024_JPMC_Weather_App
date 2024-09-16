//
//  HistoryViewModel.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/16/24.
//

import SwiftUI
import Combine

class HistoryViewModel: ObservableObject {
    @Published var searchHistory: [String] = []
    
    private let historyKey = "weatherSearchHistory"
    
    init() {
        loadHistory()
    }
    
    func saveSearch(city: String) {
        if !searchHistory.contains(city) {
            searchHistory.insert(city, at: 0)  // Add to the beginning of the array
            UserDefaults.standard.set(searchHistory, forKey: historyKey)
        }
    }
    
    func loadHistory() {
        searchHistory = UserDefaults.standard.stringArray(forKey: historyKey) ?? []
    }
    
    func clearHistory() {
        searchHistory.removeAll()
        UserDefaults.standard.removeObject(forKey: historyKey)
    }
}
