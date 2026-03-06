//
//  MainTabView.swift
//  sudoku
//
//  Created by icos on 6.03.2026.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Ana Sayfa")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Ayarlar")
                }
        }
    }
}

#Preview {
    MainTabView()
}