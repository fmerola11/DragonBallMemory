//
//  DangerView.swift
//  MemoryGame
//
//  Created by Francesco Merola on 24/04/23.
//

import SwiftUI
import AVFoundation

struct DangerView: View {
    
    @State private var animate = false
    @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        ZStack {
            Color("Background Color").ignoresSafeArea()
            VStack (spacing: 20) {
                Text("DANGER")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.red)
                    .scaleEffect(animate ? 1.4 : 1.0)
                Image("Scouter")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text("Vegeta is coming to Earth!")
                    .font(.title)
                    .foregroundColor(.red)
                Text("His spacecraft has been sighted!")
                    .font(.title2)
                    .foregroundColor(.red)
                
            }
            .onAppear {
                let soundURL = Bundle.main.url(forResource: "Danger Alarm", withExtension: "mp3")
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
                    self.audioPlayer.numberOfLoops = -1
                    self.audioPlayer.play()
                } catch {
                    print("Error playing background sound")
                }
                withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                    self.animate.toggle()
                    
                }
            }
            .onDisappear {
                self.audioPlayer.stop()
            }
        }
    }
}

struct DangerView_Previews: PreviewProvider {
    
    static var previews: some View {
        DangerView()
    }
}
