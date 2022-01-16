//
//  Alert.swift
//  Snake-swiftUI
//
//  Created by Tudor Octavian Ana on 16.01.2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContainer {
    static let gameOverAlert = AlertItem(title: Text("Game over"), message: Text("You lost."), buttonTitle: Text("Start over"))
}
