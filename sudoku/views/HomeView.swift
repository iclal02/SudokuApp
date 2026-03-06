//
//  HomeView.swift
//  sudoku
//
//  Created by icos on 4.03.2026.
//

import SwiftUI
import UIKit

struct HomeView: View {
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
                                .padding(.leading,0)                                .foregroundColor(Color(red: 164/255, green: 164/255, blue: 164/255))
                            Text(" ico krhsr ")
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
                            Text("1250")
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
                
                HStack (spacing:8) {
                    
                    // KOLAY
                    VStack (spacing: 8){
                        Image(systemName: "bolt")
                            .font(.title2)
                        Text("KOLAY")
                            .font(.system(size: 17))
                            .italic()
                        
                    }.frame(width:115,height: 100)
                        .foregroundStyle(Color(red: 58/255, green: 58/255, blue: 58/255))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.7),style: StrokeStyle(lineWidth: 2, dash: [6]))
                        )
                    
                    // ORTA
                    VStack (spacing: 8){
                        Image(systemName: "star")
                        Text("ORTA")
                            .font(.system(size: 17))
                            .italic()
                        
                    }.foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
                    .frame(width:115,height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.5), radius:6 , x: 0, y: 4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 85/255, green: 107/255, blue: 47/255),lineWidth:2)
                        )
                    
                    // ZOR
                    VStack (spacing: 8){
                        Image(systemName: "trophy")
                        Text("ZOR")
                            .font(.system(size: 17))
                            .italic()
                        
                    }.frame(width:115,height: 100)
                        .foregroundStyle(Color(red: 58/255, green: 58/255, blue: 58/255))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.7),style: StrokeStyle(lineWidth: 2, dash: [6]))
                        )
                }
                
                // MARK: - BAŞLATMA BUTONU
                Button{
                    print("yeni oyun baslatıldı")
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
                        
                        Text("42")
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
                        
                        Text("18saat")
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
                        print("Button tapped")
                    } label: {
                        Text("Hepsini Gör")
                            .font(.system(size: 16))
                            .padding(.trailing,2)
                        Image(systemName: "chevron.right")
                    }.foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
                    
                }.padding(5)
                
                
                VStack(spacing: 12) {
                    
                    HStack(alignment: .top, spacing: 14) {
                        
                        ZStack(){
                            Image(systemName: "gamecontroller")
                                .foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
                                .font(Font.system(size: 25))
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 0.5)
                                .frame(width: 60, height: 60)
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("ZOR SUDOKU")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))
                            
                            HStack(spacing: 12) {
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "clock")
                                    Text("12:40")
                                }
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "calendar")
                                    Text("Bugün")
                                }
                            }
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 14) {
                            Text("%45")
                                .foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
                                .font(.system(size: 14, weight: .bold))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 85/255, green: 107/255, blue: 47/255), lineWidth: 1)
                                )
                            
                            Button {
                                print("Button tapped")
                            } label: {
                                Image(systemName: "chevron.right")
                            }.foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .frame(height: 8)
                        
                        Rectangle()
                            .fill(Color(red: 85/255, green: 107/255, blue: 47/255))
                            .frame(width: 140, height: 6)
                            .padding(.leading, 1)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .frame(height:120)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 243/255, green: 246/255, blue: 244/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 2))
                )
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 85/255, green: 107/255, blue: 47/255))
                        .shadow(color: .black.opacity(0.8), radius:1 , x: 0, y: 0)
                )
                
                
                
                
                
            }
            }// vstack end
        }// scroll end
    } // var end
}// struct end


#Preview {
    HomeView()
}
