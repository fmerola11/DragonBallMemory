//
//  OnboardingView.swift
//  MemoryGame
//
//  Created by Francesco Merola on 24/04/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var session = SessionManager()
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color("Background Color").ignoresSafeArea()
            
            TabView {
                DangerView()
                NacelleView()
                    .overlay (alignment: .bottom) {
                        Button("Let's gather allies!") {
                            action()
                        }
                        .frame(width: 350, height: 80)
                        .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding(.top, -150)
                        .font(.system(size: 40, weight: .medium, design: .rounded))
                        .foregroundColor(.red)
                        .transition(.scale.combined(with: .opacity))
                    }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        OnboardingView(action: {})
    }
}
