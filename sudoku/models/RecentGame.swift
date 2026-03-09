//
//  RecentGame.swift
//  sudoku
//
//  Created by icos on 7.03.2026.
//

import Foundation
import CoreGraphics

struct RecentGame: Identifiable{
    let id = UUID()
    let title: String // ex: zor sudoku
    let duration: String // 12.40
    let dateText: String // bugün
    let progressText: String // %45
    let progressValue: CGFloat // bar doluluk oranı
    let isCompleted: Bool // tamamlanmış mı 
}
