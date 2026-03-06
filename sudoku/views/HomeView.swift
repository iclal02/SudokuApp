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
        
        HStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80,height: 70)
                .frame(maxWidth:.infinity, alignment: .leading)
            
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
                
                ZStack { // hoşgeldin tablosu
                    
                    GeometryReader { geo in
                        HStack {
                            
                            VStack {
                                Text("HOŞ GELDİN, ")
                                    .font(.subheadline)
                                    .italic(true)
                                    .padding(.leading,0)
                                Text(" icoş krhsr ")
                                    .font(.title)
                                    .bold()
                                
                            }.frame(width: geo.size.width * 0.7,height: 90)
                                .position(x: geo.size.width * 0.25, y: 45)
                                .foregroundColor(Color(red: 58/255, green: 58/255, blue: 58/255))
                            
                            VStack {
                                Text("PUAN")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(Color(red: 75/255, green: 83/255, blue: 32/255))
                                Text("1250")
                                    .font(.title)
                                    .foregroundColor(Color(red: 85/255, green: 107/255, blue: 47/255))
                                
                            }.frame(width: geo.size.width * 0.3,height: 90)
                            
                        }
                    }// geo end
                } // zstack end
                .frame(width: UIScreen.main.bounds.width - 15, height: 100, alignment:.topLeading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 175/255, green: 167/255, blue: 155/255))
                        .shadow(color: .black.opacity(0.7), radius:9 , x: 0, y: 5)
                )
                .position(x: UIScreen.main.bounds.width / 2,y: 50)
                
                
                
                // MARK: - zorluk derecesi
                
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
                        Image(systemName: "bolt.fill")
                            .font(.title2)
                            
                        Text("KOLAY")
                            .font(.custom("wheel", size: 20))
                            
                        
                    }.frame(maxWidth:.infinity)
                        .frame(height:90)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5),style: StrokeStyle(lineWidth: 2, dash: [6]))
                                           )
                    
                    // ORTA
                    VStack (spacing: 8){
                        Image(systemName: "star")
                            
                        Text("ORTA")
                            .font(.custom("Wheel", size: 20))
                        
                    }.frame(maxWidth:.infinity)
                        .frame(height:90)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.15), radius:6 , x: 0, y: 4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black,lineWidth:2)
                        )

                    // ZOR
                    VStack (spacing: 8){
                        Image(systemName: "trophy")
                            
                        Text("ZOR")
                            .font(.custom("wheel", size: 20))
                    }.frame(maxWidth:.infinity)
                        .frame(height:90)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5),style: StrokeStyle(lineWidth: 2, dash: [6]))
                        )

                    
                }
                
                
                
                
                
                
            }// vstack end
        }// scroll end
    } // var end
}// struct end


#Preview {
    HomeView()
}
