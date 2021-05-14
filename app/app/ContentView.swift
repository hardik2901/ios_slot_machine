//
//  ContentView.swift
//  app
//
//  Created by Hardik Vats on 12/05/21.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer?

func playSound(_ sound: String) {
    guard let url = Bundle.main.url(forResource: "slot-machine", withExtension: "mp3") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

        guard let player = player else { return }
        print("Playing the sound")
        player.play()

    } catch let error {
        print(error.localizedDescription)
    }
}

struct ContentView: View {
    
    @State private var scoreCredits : Int = 100
    @State private var firstimage : Int = 0
    @State private var secondimage : Int = 0
    @State private var thirdImage : Int = 0
    private var names = ["ping-pong","skate-board","roller-skate"]
   
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
                .shadow(radius: 10
                )
            VStack{
                
                HStack{
                    //Reset
                    Spacer()
                    Button(action: {
                        self.firstimage = 0
                        self.secondimage = 0
                        self.thirdImage = 0
                        self.scoreCredits = 100
                    }, label: {
                        Text("Reset")
                            .padding([.trailing,.leading],10)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(20)
                    })
                }
                
                Spacer()
                HStack{
                    //Title
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        
                    
                    Text("SwiftUI Slots!")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(2)
                
                Spacer()
                
                HStack{
                    //credit counter
                    Text("Credits : " + String(scoreCredits))
                        .foregroundColor(.black)
                        .padding(.all,10)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                        
                }
                Spacer()
                HStack{
    
                    Image(names[firstimage])
                        .resizable()
                        .aspectRatio(1,contentMode: .fit)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    Image(names[secondimage])
                        .resizable()
                        .aspectRatio(1,contentMode: .fit)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    Image(names[thirdImage])
                        .resizable()
                        .aspectRatio(1,contentMode: .fit)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                }.padding()
                
                Spacer()
                
                HStack{
                    Button(action: {
                        playSound("slot-machine")
                        scoreCredits -= 10
                        self.firstimage  = Int.random(in: 0 ... 2)
                        self.secondimage = Int.random(in: 0 ... 2)
                        self.thirdImage = Int.random(in: 0 ... 2)
                        
                        if firstimage == secondimage && secondimage == thirdImage{
                            scoreCredits += 100
                        }
                        else if firstimage == secondimage || secondimage == thirdImage || thirdImage == firstimage{
                            scoreCredits += 20
                        }
                        else{
                            scoreCredits -= 50
                        }
                    }, label: {
                        Text("Spin")
                            .foregroundColor(.white)
                            .padding(.all)
                            .padding([.trailing,.leading],30)
                            .background(Color.pink)
                            .cornerRadius(20)
                    })
                }
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            
        }
    }
}
