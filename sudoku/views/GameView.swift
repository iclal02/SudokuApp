//
//  GameView.swift
//  sudoku
//
//  Created by icos on 4.03.2026.
//

import SwiftUI
import Combine

struct GameView: View {
    
    let difficulty: Difficulty // zorluk seviyesi verisi dışardan gelir
    @Environment(\.dismiss) private var dismiss // SwiftUI bana bu ekranı kapatabilecek bir fonksiyon ver. dismiss bir fonk ve fullScreenCover ekranları dismiss ile kapanır. Enviroment olmasının nedeni sistemin içinden gelmesi.
    private let gameTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var selectedNumber: Int? = 5
    @State private var selectedCell: Int? = 40
    @State private var userEntries: [Int: Int] = [:] // bu sözlük yapısında nereye hangi sayının yazıldığı tutuluyor
    @State private var elapsedSeconds = 0
    @State private var mistakes = 0
    @State private var moveHistory: [Move] = []
    @State private var showGameOver = false

    
    private var difficultyTint: Color { // dışardan gelen zorluk seviyesine göre renk seçimi
        switch difficulty {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
    
    private var formattedTime: String {
        let minutes = elapsedSeconds / 60
        let seconds = elapsedSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private var mistakesText: String {
        "\(mistakes)/3"
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    headerSection
                    statsCard
                    boardSection
                    boardLegend
                    numberPadSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 32)
            }
            .disabled(showGameOver)

            if showGameOver {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()

                gameOverCard
                    .padding(.horizontal, 24)
            }
        }
        .onReceive(gameTimer) { _ in
            guard !showGameOver else { return }
            elapsedSeconds += 1
        }
        .animation(.easeInOut(duration: 0.2), value: showGameOver)
    }

    private var headerSection: some View {
        HStack(spacing: 14) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 6)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Sudoku")
                    .font(.title2.bold())
                Text("\(difficulty.rawValue) seviye")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                print("ayarlar")
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 6)
            }
        }
    }

    private var statsCard: some View {
        HStack {
            statItem(title: "SÜRE", value: formattedTime)

            Spacer()

            VStack(spacing: 8) {
                Text("ZORLUK")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.secondary)

                Text(difficulty.rawValue)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(difficultyTint)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(difficultyTint.opacity(0.14))
                    .clipShape(Capsule())
            }

            Spacer()

            statItem(title: "HATALAR", value: mistakesText)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.07), radius: 16, x: 0, y: 8)
        )
    }

    private var gameOverCard: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Image(systemName: "xmark.octagon.fill")
                    .font(.system(size: 42))
                    .foregroundStyle(.red)

                Text("Oyun Bitti")
                    .font(.title2.bold())

                Text("3 hata hakkını doldurdun.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 14) {
                gameOverInfoRow(title: "Geçen Süre", value: formattedTime)
                gameOverInfoRow(title: "Hata Sayısı", value: mistakesText)
            }
            .padding(16)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 18))

            Button {
                resetGame()
            } label: {
                Text("Baştan Başla")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .buttonStyle(.plain)
        }
        .padding(24)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: .black.opacity(0.18), radius: 24, x: 0, y: 12)
    }

    private var boardSection: some View {
        VStack(spacing: 14) {
            HStack {
                Text("Oyun Tahtası")
                    .font(.headline)
                Spacer()
                Text("Boş hücre seç")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            GeometryReader { geometry in
                let boardSize = geometry.size.width
                let cellSize = boardSize / 9

                ZStack {
                    RoundedRectangle(cornerRadius: 24) // en dış alan
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 10)

                    VStack(spacing: 0) {
                        ForEach(0..<9, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<9, id: \.self) { column in
                                    let index = row * 9 + column

                                    ZStack { // hücre görünümü
                                        Rectangle()
                                            .fill(cellBackground(for: index)) // arkaplan rengini cellBackground belirliyor

                                        Text(displayValue(for: index)) // sayı yazısına displayValue belirliyor
                                            .font(.system(size: 18, weight: isGivenCell(index) ? .bold : .semibold))
                                            .foregroundStyle(cellTextColor(for: index))
                                    }
                                    .frame(width: cellSize, height: cellSize)
                                    .overlay( // ince çizgiler
                                        Rectangle()
                                            .stroke(Color.black.opacity(0.08), lineWidth: 0.5)
                                    )
                                    .onTapGesture { // hücreye tıklama
                                        guard !isGivenCell(index) else { return } // isgivencell ile hücre boş mu kontrolu yapılıyor ona göre seçilip seçilmemesine karar veriliyor
                                        selectedCell = index
                                    }
                                }
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 24))

                    Path { path in // kalın çizgiler
                        for line in 1..<9 {
                            let position = CGFloat(line) * cellSize
                            let thickness: CGFloat = (line == 3 || line == 6) ? 2 : 0.8

                            path.addRoundedRect(
                                in: CGRect(x: position - thickness / 2, y: 0, width: thickness, height: boardSize),
                                cornerSize: .zero
                            )

                            path.addRoundedRect(
                                in: CGRect(x: 0, y: position - thickness / 2, width: boardSize, height: thickness),
                                cornerSize: .zero
                            )
                        }
                    }
                    .fill(Color.black.opacity(0.22))

                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.black.opacity(0.10), lineWidth: 1)
                }
            }
            .aspectRatio(1, contentMode: .fit) // sudoku tahtasını sabit karede tutuyor
        }
    }

    private var boardLegend: some View {
        HStack(spacing: 16) {
            legendItem(color: Color.primary.opacity(0.9), title: "Sabit sayı")
            legendItem(color: difficultyTint.opacity(0.9), title: "Seçili alan")
            Spacer()
            Text(lastMoveDescription())
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
        }
        .padding(.horizontal, 4)
    }


    private var numberPadSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Sayı Seçimi")
                        .font(.headline)
                    Text("Bir sayı seçip tahtadaki boş hücreye yerleştir")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(difficultyTint.opacity(0.14))
                        .frame(width: 48, height: 48)

                    Text(selectedNumber.map { "\($0)" } ?? "-")
                        .font(.title3.bold())
                        .foregroundStyle(difficultyTint)
                }
            }

            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    ForEach(1...5, id: \.self) { num in
                        numberButton(num)
                    }
                }

                HStack(spacing: 10) {
                    ForEach(6...9, id: \.self) { num in
                        numberButton(num)
                    }

                    Button {
                        guard let selectedCell else { return } // seçili hücre var mı kontrolü
                        
                        let oldValue = userEntries[selectedCell]
                            guard oldValue != nil else {
                                selectedNumber = nil
                                return
                            }

                            moveHistory.append(
                                Move(cellIndex: selectedCell, oldValue: oldValue, newValue: nil)
                            )
                        
                        userEntries[selectedCell] = nil // varsa o hücredeki kullanıcı girişini siliyor
                        selectedNumber = nil // seçili sayıyı da kaldırıyor
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: "delete.left")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Sil")
                                .font(.caption2.weight(.semibold))
                        }
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.black.opacity(0.06), lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 18, x: 0, y: 10)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        )
    }

    private func statItem(title: String, value: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title3.bold())
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity)
    }

    private func legendItem(color: Color, title: String) -> some View {
        HStack(spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)

            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
        }
    }

    private func gameOverInfoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
        }
    }


    private func numberButton(_ number: Int) -> some View {
        Button {
            selectedNumber = number
            guard let selectedCell else { return }
            let oldValue = userEntries[selectedCell]
            userEntries[selectedCell] = number
            
            moveHistory.append(
                        Move(cellIndex: selectedCell, oldValue: oldValue, newValue: number)
                    )

            if number != solutionValue(for: selectedCell), oldValue != number {
                mistakes += 1

                if mistakes >= 3 {
                    showGameOver = true
                }
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(selectedNumber == number ? difficultyTint.opacity(0.18) : Color(.systemGray6))

                RoundedRectangle(cornerRadius: 18)
                    .stroke(
                        selectedNumber == number ? difficultyTint.opacity(0.55) : Color.black.opacity(0.06),
                        lineWidth: selectedNumber == number ? 1.6 : 1
                    )

                VStack(spacing: 2) {
                    Text("\(number)")
                        .font(.title3.bold())
                        .foregroundStyle(selectedNumber == number ? difficultyTint : .primary)

                    if selectedNumber == number {
                        Text("Seçili")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(difficultyTint)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .shadow(
                color: selectedNumber == number ? difficultyTint.opacity(0.12) : .clear,
                radius: 8,
                x: 0,
                y: 4
            )
        }
        .buttonStyle(.plain)
    }

    private func sampleValue(for index: Int) -> String {
        let values: [Int: String] = [
            0: "5", 1: "3", 4: "7",
            9: "6", 12: "1", 13: "9", 14: "5",
            19: "9", 20: "8", 25: "6",
            27: "8", 31: "6", 35: "3",
            36: "4", 39: "8", 41: "3", 44: "1",
            45: "7", 49: "2", 53: "6",
            55: "6", 60: "2", 61: "8",
            66: "4", 67: "1", 68: "9", 71: "5",
            76: "8", 79: "7", 80: "9"
        ]

        return values[index] ?? ""
    }
    
    private func solutionValue(for index: Int) -> Int {
        let solution: [Int] = [
            5, 3, 4, 6, 7, 8, 9, 1, 2,
            6, 7, 2, 1, 9, 5, 3, 4, 8,
            1, 9, 8, 3, 4, 2, 5, 6, 7,
            8, 5, 9, 7, 6, 1, 4, 2, 3,
            4, 2, 6, 8, 5, 3, 7, 9, 1,
            7, 1, 3, 9, 2, 4, 8, 5, 6,
            9, 6, 1, 5, 3, 7, 2, 8, 4,
            2, 8, 7, 4, 1, 9, 6, 3, 5,
            3, 4, 5, 2, 8, 6, 1, 7, 9
        ]

        return solution[index]
    }
    

    private func displayValue(for index: Int) -> String { // hücrede bir şey yazıyor mu?
        if let userValue = userEntries[index] {
            return String(userValue)
        }

        return sampleValue(for: index)
    }
    
    private func lastMoveDescription() -> String {
        guard let lastMove = moveHistory.last else {
            return "Henüz hamle yok"
        }

        let row = lastMove.cellIndex / 9 + 1
        let column = lastMove.cellIndex % 9 + 1
        let oldText = lastMove.oldValue.map(String.init) ?? "boş"
        let newText = lastMove.newValue.map(String.init) ?? "boş"

        return "Son hamle: R\(row) C\(column) • \(oldText) → \(newText)"
    }

    private func resetGame() {
        selectedNumber = 5
        selectedCell = 40
        userEntries = [:]
        elapsedSeconds = 0
        mistakes = 0
        moveHistory = []
        showGameOver = false
    }
    

    private func isGivenCell(_ index: Int) -> Bool { // hücrede başta yazı yazıyor muydu?
        !sampleValue(for: index).isEmpty
    }

    private func cellBackground(for index: Int) -> Color {
        guard let selectedCell else {
            return .white
        }

        if index == selectedCell {
            return difficultyTint.opacity(0.20)
        }

        let selectedRow = selectedCell / 9
        let selectedColumn = selectedCell % 9
        let row = index / 9
        let column = index % 9

        if row == selectedRow || column == selectedColumn {
            return difficultyTint.opacity(0.08)
        }

        return .white
    }

    private func cellTextColor(for index: Int) -> Color {
        if index == selectedCell {
            return difficultyTint
        }

        if isGivenCell(index) {
            return .primary
        }

        if userEntries[index] != nil {
            return difficultyTint.opacity(0.95)
        }

        return .secondary
    }
}

#Preview {
    GameView(difficulty: .medium)
        .preferredColorScheme(.light)
}
