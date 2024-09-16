//
//  app/ContentView.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/14/24.
//
//i want the Main component to be displayed here and have this file act as the "view" of my MVVM app

import SwiftUI

struct ContentView: View {
    @StateObject var mainViewModel = MainViewModel()

    var body: some View {
        MainView(viewModel: mainViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
