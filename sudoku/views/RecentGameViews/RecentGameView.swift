//
//  RecentGameView.swift
//  sudoku
//
//  Created by icos on 9.03.2026.
//

import SwiftUI

struct RecentGameView: View {
    
    let games : [RecentGame]
    
    var body: some View {
        NavigationStack { // navbar olusturur geri butonu ve sayfa baslığı ekleriz
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            ForEach(games) { game in
                                RecentGameCard(game: game)
                            }
                            
                        }
                        .padding()
                    }
                    .navigationTitle("Tüm Oyunlar")
                    .navigationBarTitleDisplayMode(.inline) // navbardaki yazı boyutunu belirledik
                }
    }
}

#Preview {
    RecentGameView(games: [
        RecentGame(
            title: "ZOR SUDOKU",
            duration: "12:40",
            dateText: "Bugün",
            progressValue: 0.45,
            isCompleted: false
        )
    ]
)
}
