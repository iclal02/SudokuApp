//
//  RecentGameCard.swift
//  sudoku
//
//  Created by icos on 7.03.2026.
//

import SwiftUI

struct RecentGameCard: View {
    
    let game: RecentGame
    
    @State private var showOngoingGameView = false
    @State private var showCompletedGameView = false
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            HStack(alignment: .top, spacing: 14) {
                
                // oyun kolu kutusu
                ZStack {
                    Image(systemName: "gamecontroller")
                        .foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
                        .font(.system(size: 25))
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 0.5)
                        .frame(width: 60, height: 60)
                }
                
                // oyun ismi - gün - saat
                VStack(alignment: .leading, spacing: 8) {
                    Text(game.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))
                    
                    HStack(spacing: 12) {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                            Text(game.duration)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                            Text(game.dateText)
                        }
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                }
                
                Spacer()
                
                // yüzde - oyun özeti butonu
                VStack(alignment: .trailing, spacing: 14) {
                    Text(game.progressText)
                        .foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
                        .font(.system(size: 14, weight: .bold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 85/255, green: 107/255, blue: 47/255), lineWidth: 1)
                        )
                    
                    Button {
                        if game.isCompleted {
                            showCompletedGameView = true
                            print("CompletegameView açılacak")
                        }
                        else {
                            showOngoingGameView = true
                            print("OngoingGameView açılacak")
                        }
                        print("oyun özeti açıldı")
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))
                }
            }
            
            //  doluluk barı
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .frame(height: 8)
                    
                    Rectangle()
                        .fill(Color(red: 85/255, green: 107/255, blue: 47/255))
                        .frame(width: geo.size.width * game.progressValue, height: 6)
                        .padding(.leading, 1)
                }
            }
            .frame(height: 8)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 243/255, green: 246/255, blue: 244/255))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                )
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 85/255, green: 107/255, blue: 47/255))
                .shadow(color: .black.opacity(0.8), radius: 1, x: 0, y: 0)
        )
        .sheet( isPresented: $showOngoingGameView){
            OngoingGameView(game:game)
        }
        .sheet(isPresented: $showCompletedGameView){
            CompletedGameView(game:game)
        }

    }
}
    


#Preview {
    RecentGameCard(
        game: RecentGame(
            title: "ZOR SUDOKU",
            duration: "12:40",
            dateText: "Bugün",
            progressText: "%45",
            progressValue: 0.45,
            isCompleted: false
        )
    )
}
