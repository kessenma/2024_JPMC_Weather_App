//
//  app/ContentView.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/14/24.
//
//i want the Main component to be displayed here and have this file act as the "view" of my MVVM app

import SwiftUI

struct ContentView: View {
    @StateObject private var historyViewModel = HistoryViewModel()
    @StateObject private var cityViewModel: CityViewModel
    @StateObject private var mainViewModel = MainViewModel()

    init() {
        let history = HistoryViewModel()
        _historyViewModel = StateObject(wrappedValue: history)
        _cityViewModel = StateObject(wrappedValue: CityViewModel(historyViewModel: history))
        _mainViewModel = StateObject(wrappedValue: MainViewModel())
    }

    var body: some View {
        MainView(viewModel: mainViewModel, historyViewModel: historyViewModel, cityViewModel: cityViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
