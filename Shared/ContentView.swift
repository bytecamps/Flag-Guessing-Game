//
//  ContentView.swift
//  Shared
//
//  Created by Rosalie Wessels on 1/7/22.
//

import SwiftUI

struct ContentView: View {
    @State var feedbackText = "Which country is this flag from?"
    @State var code = "nl"
    @State var name = "The Netherlands"
    @State var firstButton = "Russia"
    @State var secondButton = "The Netherlands"
    @State var thirdButton = "Luxembourg"
    @State var score = 0
    
    var body: some View {
        VStack {
            VStack (spacing: 20) {
                Text("Flag Guessing Game!")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                
                Text(feedbackText)
                    .multilineTextAlignment(.center)
            
            }
            
            Spacer()
            
            AsyncImage(url: URL(string: "https://flagcdn.com/256x192/\(code).png"))
                .padding(.horizontal, UIScreen.main.bounds.width / 8)
            
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: {checkAnswer(answer: firstButton)}) {
                    Text(firstButton)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(20)
                
                Button(action: {checkAnswer(answer: secondButton)}) {
                    Text(secondButton)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(20)
                
                Button(action: {checkAnswer(answer: thirdButton)}) {
                    Text(thirdButton)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(20)
            }
            .padding(.horizontal, UIScreen.main.bounds.width / 16)
        }
        .padding(.top, 10)
        .onAppear(perform: newCountry)
    }
    
    func newCountry() {
        let newCountries = countryData[randomPick: 3]
        print(newCountries)
        code = newCountries[0].code
        name = newCountries[0].name
        
        var buttonCountries = [name, newCountries[1].name, newCountries[2].name]
        buttonCountries.shuffle()
        
        firstButton = buttonCountries[0]
        secondButton = buttonCountries[1]
        thirdButton = buttonCountries[2]
    }
    
    func checkAnswer(answer: String) {
        print(answer)
        print(name)
        if answer == name {
            score += 1
            feedbackText = "Hurray! You got it right! Your score is \(score)"
            newCountry()
        }
        else {
            feedbackText = "That's wrong! Try better! Your score is \(score)"
            newCountry()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Array {
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}
