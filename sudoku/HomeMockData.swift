//
//  HomeMockData.swift
//  sudoku
//
//  Created by icos on 8.04.2026.
//


import Foundation

struct HomeMockData {
    static let playerStats = PlayerStats(
        username: "ico krhsr",
        score: 1250,
        wins: 43,
        totalTime: "18 saat"
    )

    static let recentGames: [RecentGame] = [
        RecentGame(
            title: "ZOR SUDOKU",
            duration: "12:40",
            dateText: "Bugün",
            progressValue: 0.45,
            isCompleted: false
        ),
        RecentGame(
            title: "ORTA SUDOKU",
            duration: "08:15",
            dateText: "Dün",
            progressValue: 0.80,
            isCompleted: true
        )
    ]
}
