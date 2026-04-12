//
//  CompletedGameView.swift
//  sudoku
//
//  Created by icos on 9.03.2026.
//

import SwiftUI

struct CompletedGameView: View {
    let game: RecentGame
    let mistakes: Int
    let totalScore: Int
    let board: [[String]]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                topBar
                heroSection
                statsSection
                summarySection
                actionButtons
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .padding(.bottom, 28)
        }
        .background(Color(red: 245/255, green: 245/255, blue: 243/255))
    }

    
    
    private var topBar: some View {
        HStack {
            Text("Oyun Tamamlandı")
                .font(.system(size: 31, weight: .bold))
                .foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))

            Spacer()
        }
        .padding(.top, 6)
    }

    private var heroSection: some View {
        VStack(spacing: 18) {
            VStack(spacing: 6) {
                Text("YENİ REKOR")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))

                ZStack {
                    Circle()
                        .fill(Color(red: 232/255, green: 236/255, blue: 226/255))
                        .frame(width: 88, height: 88)

                    Image(systemName: "trophy")
                        .font(.system(size: 42, weight: .regular))
                        .foregroundStyle(Color(red: 136/255, green: 160/255, blue: 112/255))
                }
            }

            VStack(spacing: 8) {
                Text("TEBRİKLER!")
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))

                Text("Harika bir performans sergiledin.")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.gray)
            }

            HStack(spacing: 12) {
                Image(systemName: "star")
                Image(systemName: "star.fill")
                Image(systemName: "star")
            }
            .font(.system(size: 24, weight: .medium))
            .foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))

            VStack(spacing: 4) {
                Text("TOPLAM PUAN")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color(red: 136/255, green: 160/255, blue: 112/255))

                Text("\(totalScore)")
                    .font(.system(size: 34, weight: .heavy))
                    .foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
            }
            .frame(maxWidth: 190)
            .frame(height: 96)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(red: 230/255, green: 237/255, blue: 220/255))
                    .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 12)
    }

    private var statsSection: some View {
        HStack(spacing: 14) {
            statCard(icon: "timer", title: "SÜRE", value: game.duration)
            statCard(icon: "bolt", title: "ZORLUK", value: formattedDifficulty)
            statCard(icon: "xmark.circle", title: "HATA", value: "\(mistakes)")
        }
    }

    private func statCard(icon: String, title: String, value: String) -> some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(red: 240/255, green: 243/255, blue: 236/255))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
            }

            VStack(spacing: 6) {
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.gray)

                Text(value)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 118)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        )
    }

    private var summarySection: some View {
        VStack(spacing: 14) {
            Text("OYUN ÖZETİ")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.gray)

            VStack(spacing: 0) {
                ForEach(0..<9, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<9, id: \.self) { column in
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 247/255, green: 249/255, blue: 243/255))
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color(red: 223/255, green: 229/255, blue: 215/255), lineWidth: 0.5)
                                    )

                                Text(board[row][column])
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(numberColor(forRow: row, column: column))
                            }
                            .frame(width: 26, height: 26)
                        }
                    }
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(red: 242/255, green: 246/255, blue: 237/255))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color(red: 215/255, green: 223/255, blue: 205/255), lineWidth: 2)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
            )
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 14) {
            Button {
                print("tekrar oyna")
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Tekrar Oyna")
                        .font(.system(size: 18, weight: .bold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color(red: 85/255, green: 107/255, blue: 47/255))
                )
            }

            Button {
                print("sonucu paylaş")
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "square.and.arrow.up")
                    Text("Sonucu Paylaş")
                        .font(.system(size: 18, weight: .bold))
                }
                .foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(Color(red: 196/255, green: 205/255, blue: 185/255), lineWidth: 2)
                        )
                )
            }

            Button {
                print("ana sayfaya dön")
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "house")
                    Text("Ana Sayfaya Dön")
                        .font(.system(size: 17, weight: .semibold))
                }
                .foregroundStyle(Color.gray)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
            }
        }
        .padding(.top, 6)
    }

    private var formattedDifficulty: String {
        game.title.replacingOccurrences(of: " SUDOKU", with: "").capitalized
    }

    private func numberColor(forRow row: Int, column: Int) -> Color {
        let greenPositions: Set<String> = [
            "0-0", "0-2", "0-6", "0-7",
            "1-1", "1-5", "1-6",
            "2-0", "2-4", "2-6", "2-7",
            "3-0", "3-4", "3-6",
            "4-4", "4-6", "4-8",
            "5-1", "5-2", "5-4",
            "6-0", "6-4", "6-6", "6-7",
            "7-4", "7-5", "7-7",
            "8-0", "8-2", "8-6", "8-8"
        ]

        return greenPositions.contains("\(row)-\(column)")
        ? Color(red: 85/255, green: 107/255, blue: 47/255)
        : Color(red: 24/255, green: 29/255, blue: 35/255)
    }
}

#Preview {
    CompletedGameView(
        game: RecentGame(
            title: "ZOR SUDOKU",
            duration: "12:40",
            dateText: "Bugün",
            progressValue: 1.0,
            isCompleted: true
        ),
        mistakes: 1,
        totalScore: 1250,
        board: [
            ["5", "3", "4", "6", "7", "8", "9", "1", "2"],
            ["6", "7", "2", "1", "9", "5", "3", "4", "8"],
            ["1", "9", "8", "3", "4", "2", "5", "6", "7"],
            ["8", "5", "9", "7", "6", "1", "4", "2", "3"],
            ["4", "2", "6", "8", "5", "3", "7", "9", "1"],
            ["7", "1", "3", "9", "2", "4", "8", "5", "6"],
            ["9", "6", "1", "5", "3", "7", "2", "8", "4"],
            ["2", "8", "7", "4", "1", "9", "6", "3", "5"],
            ["3", "4", "5", "2", "8", "6", "1", "7", "9"]
        ]
    )
}
