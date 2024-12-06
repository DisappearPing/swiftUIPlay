//
//  ContentView.swift
//  warChallengeAppOriginal
//
//  Created by billHsiao on 2024/11/5.
//

import SwiftUI

struct ContentView: View {
    
    @State var playerCard = "card5"
    @State var cpuCard = "card9"
    @State var playerScore = 0
    @State var cpuScore = 0
    @State private var showAlert = false // 控制 Alert 顯示的狀態
    
    private func exchangeOver10CardToJQKString(_ card: Int) -> String {
        
        switch card {
        case 11:
            "J"
        case 12:
            "Q"
        case 13:
            "K"
        default:
            "X"
        }
        
    }
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green, Color.gray]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                Text("War!!")
                Image(systemName: "tray.fill")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.orange)
                    .frame(width: 100.0, height: 40.0)
                    .background(Color.green)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Image(playerCard)
                        .background()
                        .cornerRadius(6)
                    Spacer()
                    Image(cpuCard)
                        .background()
                        .cornerRadius(6)
                    Spacer()
                }
                
                Spacer()

                Button(action: {
                    
                    // Generate a random number 1 - 13
                    let playerRand = Int.random(in: 1...13)
                    let cpuRand = Int.random(in: 1...13)
                    
                    print("playerRand = \(playerRand)")
                    print("cpuRand = \(cpuRand)")
                    
                    // Update the cards
                    playerCard = "card" + "\(playerRand > 10 ? exchangeOver10CardToJQKString(playerRand) : String(playerRand))"
                    cpuCard = "card" + "\(cpuRand > 10 ? exchangeOver10CardToJQKString(cpuRand) : String(cpuRand))"
                    // Update the score
                    
                    let score = (playerRand == 1 ? 14 : playerRand) - (cpuRand == 1 ? 14 : cpuRand)
                                 
                    print(score)
                    
                    switch score {
                    case ..<0:
                        cpuScore += 1
                    case 1...:
                        playerScore += 1
                    default:
                        // draw
                        showAlert = true
                    }
                    
                    
                }, label: {
                    Text("Action!")
                        .foregroundStyle(Color.red)
                })

                Spacer()

                HStack {
                    
                    Spacer()
                    VStack {
                        Text("player")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 10.0)
                        Text("\(playerScore)")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 10.0)
                        Text("\(cpuScore)")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    
                }
                
                Spacer()

            }.alert("Draw!", isPresented: $showAlert) {
                Button("OK", role: .none) {
                    showAlert = false
                }
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}

//#Preview {
//    ContentView()
//        .preferredColorScheme(.dark)
//}
