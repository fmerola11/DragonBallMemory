//
//  FirstView.swift
//  MemoryGame
//
//  Created by Francesco Merola on 23/04/23.
//

import SwiftUI
import AVFoundation

struct NacelleView: View {
    
    @State private var imageYOffset: CGFloat = 0
    @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        VStack {
            ZStack {
                
                Color("Background Color").ignoresSafeArea()
                
                VStack {
                    Image("Nacell")
                        .resizable()
                        .scaledToFit()
                        .offset(y: imageYOffset)
                    Text("What an impressive speed!")
                        .foregroundColor(.red)
                        .font(.title)
                    Text("You must do something NOW!")
                        .foregroundColor(.red)
                        .font(.title)
                    Spacer()
                }
                .onAppear {
                    let soundURL = Bundle.main.url(forResource: "Nacell Sound", withExtension: "mp3")
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
                        self.audioPlayer.numberOfLoops = -1
                        self.audioPlayer.play()
                        } catch {
                            print("Error playing background sound")
                        }
                    withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                        self.imageYOffset = 20
                    }
                }
                .onDisappear {
                    self.audioPlayer.stop()
                }
            }
        }
    }
}

struct NacelleView_Previews: PreviewProvider {
    
    static var previews: some View {
        NacelleView()
    }
}
