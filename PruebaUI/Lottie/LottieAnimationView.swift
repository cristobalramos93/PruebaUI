//
//  LottieAnimationView.swift
//  PruebaUI
//
//  Created by Cristobal Ramos on 22/4/24.
//

import Foundation
import Lottie
import SwiftUI

struct LottieAnimation: UIViewRepresentable {
    let animationName: String

    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: animationName)
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }

    func updateUIView(_ uiView: LottieAnimationView, context: Context) {}
}
