//
//  HomeView.swift
//  sudoku
//
//  Created by icos on 4.03.2026.
//

import SwiftUI
import UIKit

struct HomeView: View {
    
   // state demek değişken değişirse ekranı yeniden çiz

    @State private var selectedDifficulty: Difficulty = .medium
    
    @State private var showGameView = false // game ekranı açık mı?
    @State private var showRecentGames = false
    
    @State private var playerStats = HomeMockData.playerStats
    private let recentGames = HomeMockData.recentGames
    
    var body: some View {
        
        VStack{
            // MARK: - SAYFA ÜSTÜ
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80,height: 70)
                    .frame(maxWidth:.infinity, alignment: .leading) // en sola yaslamak icin kullandık
                
                Spacer()
                
                Button {
                    print("Button tapped")
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .font(Font.system(size: 30))
                        .foregroundStyle(Color(red: 58/255, green: 58/255, blue: 58/255))
                }.padding(.trailing,20)
            }
            
            
            ScrollView {
                
                VStack(spacing:20) {
                    
                    // MARK: - KARŞILAMA TABLOSU
                    ZStack { // hoşgeldin tablosu
                        HStack {
                            VStack {
                                Text("HOŞ GELDİN, ")
                                    .font(.subheadline)
                                    .italic(true)
                                    .padding(.leading,0)
                                    .foregroundColor(Color(red: 164/255, green: 164/255, blue: 164/255))
                                Text(playerStats.username)
                                    .font(.title)
                                    .bold()
                                
                            }.frame(height: 90)
                                .foregroundColor(Color(red: 58/255, green: 58/255, blue: 58/255))
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .padding(20)
                            
                            VStack {
                                Text("PUAN")
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 75/255, green: 83/255, blue: 32/255))
                                Text("\(playerStats.score)")
                                    .font(.system(size:35))
                                    .bold()
                                    .foregroundColor(Color(red: 85/255, green: 107/255, blue: 47/255))
                                
                            }.frame(height: 90)
                                .padding(20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame( height: 110)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 236/255, green: 247/255, blue: 233/255))
                            .shadow(color: .black.opacity(0.2), radius:9 , x: 0, y: 5)
                    )
                    .padding(.top,10)
                    
                    
                    // MARK: - ZORLUK DERECESİ
                    
                    HStack (spacing: 12){
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color(red: 75/255, green: 83/255, blue: 32/255))
                        Text("ZORLUK SEÇİN")
                            .bold()
                            .foregroundStyle(Color(red: 58/255, green: 58/255, blue: 58/255))
                        
                    }.frame(maxWidth:.infinity, alignment: .leading)
                        .padding(10)
                    
                    HStack(spacing: 8) {
                        
                        // KOLAY
                        VStack(spacing: 8) {
                            Image(systemName: "bolt")
                                .font(.title2)
                            Text("KOLAY")
                                .font(.system(size: 17))
                                .italic()
                        }
                        .frame(width: 115, height: 100)
                        .foregroundStyle(selectedDifficulty == .easy ? Color(red: 85/255, green: 107/255, blue: 47/255) : Color(red: 58/255, green: 58/255, blue: 58/255)) // yazının rengi
                        .background(
                            RoundedRectangle(cornerRadius: 10) // ekrana dikdörtgen çizer
                                .fill(selectedDifficulty == .easy ? Color.white : Color.clear) // içini doldurur
                                .shadow(color: .black.opacity(selectedDifficulty == .easy ? 0.5 : 0), radius: 6, x: 0, y: 4) // gölge ekler
                        )
                        .overlay( // view üstüne başka bir view koy demek katman gibi
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( // kenarlık çizer
                                    selectedDifficulty == .easy
                                    ? Color(red: 85/255, green: 107/255, blue: 47/255)
                                    : Color.gray.opacity(0.7),
                                    style: selectedDifficulty == .easy
                                    ? StrokeStyle(lineWidth: 2)
                                    : StrokeStyle(lineWidth: 2, dash: [6]) // çizgi kalınlığı 2px, dash kesikli çizgi ekledik
                                       )
                        )
                        .onTapGesture { // buraya tıklandığında bu kod çalışsın demek
                            selectedDifficulty = .easy
                        }
                        
                        // ORTA
                        VStack(spacing: 8) {
                            Image(systemName: "star")
                            Text("ORTA")
                                .font(.system(size: 17))
                                .italic()
                        }
                        .foregroundStyle(selectedDifficulty == .medium ? Color(red: 85/255, green: 107/255, blue: 47/255) : Color(red: 58/255, green: 58/255, blue: 58/255))
                        .frame(width: 115, height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedDifficulty == .medium ? Color.white : Color.clear)
                                .shadow(color: .black.opacity(selectedDifficulty == .medium ? 0.5 : 0), radius: 6, x: 0, y: 4)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedDifficulty == .medium
                                    ? Color(red: 85/255, green: 107/255, blue: 47/255)
                                    : Color.gray.opacity(0.7),
                                    style: selectedDifficulty == .medium
                                    ? StrokeStyle(lineWidth: 2)
                                    : StrokeStyle(lineWidth: 2, dash: [6])
                                )
                        )
                        .onTapGesture {
                            selectedDifficulty = .medium
                        }
                        
                        // ZOR
                        VStack(spacing: 8) {
                            Image(systemName: "trophy")
                            Text("ZOR")
                                .font(.system(size: 17))
                                .italic()
                        }
                        .frame(width: 115, height: 100)
                        .foregroundStyle(selectedDifficulty == .hard ? Color(red: 85/255, green: 107/255, blue: 47/255) : Color(red: 58/255, green: 58/255, blue: 58/255))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedDifficulty == .hard ? Color.white : Color.clear)
                                .shadow(color: .black.opacity(selectedDifficulty == .hard ? 0.5 : 0), radius: 6, x: 0, y: 4)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedDifficulty == .hard
                                    ? Color(red: 85/255, green: 107/255, blue: 47/255)
                                    : Color.gray.opacity(0.7),
                                    style: selectedDifficulty == .hard
                                    ? StrokeStyle(lineWidth: 2)
                                    : StrokeStyle(lineWidth: 2, dash: [6])
                                )
                        )
                        .onTapGesture {
                            selectedDifficulty = .hard
                        }
                    }
                    
                    // MARK: - BAŞLATMA BUTONU
                    Button{
                        showGameView = true
                        print("yeni oyun başlatıldı: \(selectedDifficulty)")
                    } label:
                    {
                        Image(systemName: "play")
                            .font(.system(size: 24, weight: .semibold))
                        Text("YENİ OYUN BAŞLAT")
                            .font(.system(size: 23, weight: .regular))
                        
                    }.foregroundStyle(Color.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 85/255, green: 107/255, blue: 47/255))
                                .shadow(color: .black.opacity(0.7), radius:1 , x: 5, y: 5)
                        )
                    // MARK: - ÖZET
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing:10){
                                Image(systemName: "trophy.fill")
                                    .font(.system(size: 18, weight: .medium))
                                Text("GALİBİYETLER")
                                    .font(.system(size:17, weight: .regular))
                            }.foregroundStyle(Color(red: 113/255, green: 113/255, blue: 113/255))
                            
                            Text("\(playerStats.wins)")
                                .bold()
                                .font(.system(size: 24))
                                .padding(.top, 6)
                                .padding(.bottom,9)
                            
                        }    .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 18)
                            .frame(height: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(1), lineWidth: 1)
                                    .shadow(color: .black.opacity(0.9), radius:0.9 , x: 0, y: 0)
                            )
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(){
                                Image(systemName: "clock.fill")
                                    .font(.system(size: 18, weight: .medium))
                                Text("GEÇİRİLEN SÜRE")
                                    .font(.system(size:17, weight: .regular))
                            }.foregroundStyle(Color(red: 133/255, green: 133/255, blue: 133/255))
                            
                            Text(playerStats.totalTime)
                                .bold()
                                .font(.system(size: 24))
                                .padding(.top, 6)
                                .padding(.bottom,9)
                            
                        }    .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 18)
                            .frame(height: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(1), lineWidth: 1)
                                    .shadow(color: .black.opacity(0.9), radius:0.9 , x: 0, y: 0)
                            )
                    }
                    // MARK: - SON OYUNLAR
                    HStack (spacing: 10){
                        Text("SON OYUNLAR")
                            .bold()
                            .foregroundStyle(Color(red: 58/255, green: 58/255, blue: 58/255))
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.leading, 6)
                        
                        Button {
                            showRecentGames = true
                            print("hepsini gör sayfası açıldı")
                        } label: {
                            Text("Hepsini Gör")
                                .font(.system(size: 16))
                                .padding(.trailing,2)
                            Image(systemName: "chevron.right")
                        }.foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
                        
                    }.padding(5)
                    
                    // son oyun kutusu
                    ForEach(recentGames) { game in // foreach ile birden fazla örnek olursa hepsine aynısını uygulamasını istedik
                        RecentGameCard(game: game)
                        
                        
                    }// vstack end
                }// scroll end
            }
        }
        .fullScreenCover(isPresented: $showGameView) { // eğer showGameView = true ise GameView ekranını aç
            GameView(difficulty: Difficulty(rawValue: selectedDifficulty.rawValue) ?? .medium) // ekran açıldığında bu değeri de gönder
        }
        .sheet(isPresented: $showRecentGames){
            RecentGameView(games: recentGames)
        }
    }
}
#Preview {
    HomeView()
}
