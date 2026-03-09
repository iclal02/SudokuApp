//
//  OngoingGameView.swift
//  sudoku
//
//  Created by icos on 9.03.2026.
//

import SwiftUI

struct OngoingGameView: View {
    let game: RecentGame

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                topBar
                heroSection
                progressSection
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
            Text("Oyuna Devam Et")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))

            Spacer()

            Button {
                print("oyun paylaş")
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundStyle(Color(red: 85/255, green: 107/255, blue: 47/255))
            }
        }
        .padding(.top, 6)
    }

    private var heroSection: some View {
        VStack(spacing: 18) {
            ZStack {
                Circle()
                    .fill(Color(red: 232/255, green: 236/255, blue: 226/255))
                    .frame(width: 88, height: 88)

                Image(systemName: "play.fill")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundStyle(Color(red: 136/255, green: 160/255, blue: 112/255))
            }

            VStack(spacing: 8) {
                Text("OYUN DEVAM EDİYOR")
                    .font(.system(size: 27, weight: .heavy))
                    .foregroundStyle(Color(red: 24/255, green: 29/255, blue: 35/255))

                Text("Kaldığın yerden devam edebilirsin.")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.gray)
            }

            VStack(spacing: 4) {
                Text("İLERLEME")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color(red: 136/255, green: 160/255, blue: 112/255))

                Text(game.progressText)
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

    private var progressSection: some View {
        VStack(spacing: 16) {
            HStack(spacing: 14) {
                statCard(icon: "timer", title: "SÜRE", value: game.duration)
                statCard(icon: "bolt", title: "ZORLUK", value: formattedDifficulty)
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("İLERLEME DURUMU")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color.gray)

                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 232/255, green: 236/255, blue: 226/255))
                            .frame(height: 16)

                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 85/255, green: 107/255, blue: 47/255))
                            .frame(width: geo.size.width * game.progressValue, height: 16)
                    }
                }
                .frame(height: 16)
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
            )
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

                                Text(sampleBoard[row][column])
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
                print("oyuna devam et")
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "play.fill")
                    Text("Devam Et")
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
                print("oyunu bırak")
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "xmark")
                    Text("Oyunu Bırak")
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

    private let sampleBoard: [[String]] = [
        ["", "", "2", "", "", "", "", "", "2"],
        ["", "1", "", "2", "7", "", "", "", ""],
        ["", "7", "", "", "", "2", "", "9", "1"],
        ["", "8", "", "", "", "", "2", "", ""],
        ["", "", "", "", "", "1", "1", "", ""],
        ["", "", "", "", "", "5", "", "3", ""],
        ["", "", "2", "", "", "", "", "7", ""],
        ["", "", "", "5", "", "", "", "", "8"],
        ["", "2", "", "", "", "", "", "", "1"]
    ]

    private func numberColor(forRow row: Int, column: Int) -> Color {
        let greenPositions: Set<String> = [
            "1-1", "2-7", "2-8", "3-1", "3-6",
            "4-5", "4-6", "5-5", "5-7", "8-1", "8-8"
        ]

        return greenPositions.contains("\(row)-\(column)")
        ? Color(red: 85/255, green: 107/255, blue: 47/255)
        : Color(red: 24/255, green: 29/255, blue: 35/255)
    }
}

#Preview {
    OngoingGameView(
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
