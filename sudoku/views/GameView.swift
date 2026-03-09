//
//  GameView.swift
//  sudoku
//
//  Created by icos on 4.03.2026.
//

import SwiftUI

struct GameView: View {
    
    
    let difficulty: String
    @Environment(\.dismiss) private var dismiss // SwiftUI bana bu ekranı kapatabilecek bir fonksiyon ver. dismiss bir fonk ve fullScreenCover ekranları dismiss ile kapanır. Enviroment olmasının nedeni sistemin içinden gelmesi.
    private let gridItems = Array(repeating: GridItem(.flexible(),spacing: 0),count:9)
    
    var body: some View {
        VStack(spacing: 20){
            
            // top bar
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Text("Sudoku: \(difficulty)")
                    .font(.headline)
                Spacer()
                Button {
                    print("ayarlar")
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
            
            // info card
            HStack{
                VStack {
                    Text("SÜRE")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text("10:00")
                        .font(.headline)
                }
                
                Spacer()
                
                VStack {
                    Text("ZORLUK")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text(difficulty.uppercased())
                        .padding(.horizontal, 10)
                        .padding(.vertical,4)
                        .background(Color.green.opacity(0.2))
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                VStack {
                    
                    Text("HATALAR")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text("2/3")
                        .font(.headline)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(radius: 3)
            )
            
            // sudoku
            LazyVGrid(columns: gridItems, spacing: 0) {
                ForEach(0..<81) { _ in
                    Rectangle()
                        .stroke(Color.gray.opacity(0.3))
                        .frame(height: 35)
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            
            // tool button
            
            HStack(spacing:30) {
                tool(icon: "arrow.uturn.backward",text: "GERİ AL")
                tool(icon: "eraser",text: "SİL")
                tool(icon: "lightbulb",text: "İPUCU")
                tool(icon: "pencil",text: "NOTLAR")
            }
            
            // NUMBER PAD
            VStack(spacing: 10) {
                HStack(spacing:12) {
                    ForEach(1...5 , id: \.self){ num in
                        numberButton(num)
                    }
                }
                
                HStack(spacing:12) {
                    ForEach(6...9 , id: \.self){ num in
                        numberButton(num)
                    }
                }
                
            }.padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(radius: 3)
                )
            Spacer()
        }.padding()
            .background(Color(.systemGray6))
    }
    
    
    private func tool(icon: String, text: String) -> some View {
        VStack {
            Image(systemName: icon)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(text)
                .font(.caption)
        }
    }

    private func numberButton(_ number: Int) -> some View {
        Text("\(number)")
            .frame(width: 50, height: 50)
            .background(Color.white)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray.opacity(0.3)))
    }
    
    
    
    
}

#Preview {
    GameView(difficulty: "ORTA")
}
