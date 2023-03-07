//
//  ContentView.swift
//  WinOrLoseRPS
//
//  Created by Jan Stusio on 25/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var appMoves = [("Rock","👊"), ("Paper", "✋"), ("Scissors", "✌️")]
    @State private var currentAppMove = Int.random(in: 0...2)
    @State private var winOrLose = Bool.random()
    var correctAnswer: Int {
        if winOrLose == true {
            if currentAppMove == 0 {
                return 1
            } else if currentAppMove == 1 {
                return 2
            } else {
                return 0
            }
        } else {
            if currentAppMove == 0 {
                return 2
            } else if currentAppMove == 1 {
                return 0
            } else {
                return 1
            }
        }
    }
    @State private var usersScore = 0
    @State private var numberOfGames = 0
    @State private var finalScore = ""
    @State private var gameEnd = false
    
    var body: some View {
        ZStack {
            VStack {
                //Player's score
                Text("Your score is \(usersScore)")
                //App's move
                Text(appMoves[currentAppMove].1)
                //Win or lose - ternery operator
                Text(winOrLose
                     ? "win"
                     : "lose")
                //Player's choise
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            buttonTapped(number)
                        } label: {
                            Text(appMoves[number].1)
                        }
                    }
                }
            }
        }
        .alert(finalScore, isPresented: $gameEnd) {
            Button("Continue", action: restart)
        } message: {
            Text("Your finale score is \(usersScore)")
        }
    }
    func buttonTapped(_ number: Int) {
        //Check if this is the right answer
        if number == correctAnswer {
            usersScore += 1
        } else {
            usersScore -= 1
        }

        currentAppMove = Int.random(in: 0...2)
        winOrLose = Bool.random()
        numberOfGames += 1
        if numberOfGames == 10 {
            gameEnd = true
        }
    }
    func restart() {
        numberOfGames = 0
        usersScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
