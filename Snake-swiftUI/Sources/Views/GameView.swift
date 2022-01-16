//
//  GameView.swift
//  Snake-swiftUI
//
//  Created by Tudor Octavian Ana on 16.01.2022.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var viewModel: GameViewModel
    
    init(viewModel: GameViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack() {
            
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Rectangle()
                        .shadow(radius: 6)
                        .foregroundColor(.green)
                    
                    ForEach(0..<viewModel.snakePositions.count, id: \.self) { index in
                        Rectangle()
                            .foregroundColor(.yellow)
                            .frame(width: GameViewModel.snakeSize, height: GameViewModel.snakeSize)
                            .position(viewModel.snakePositions[index])
                    }
                    
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: GameViewModel.snakeSize, height: GameViewModel.snakeSize)
                        .position(viewModel.foodPosition)
                    
                }
                .onReceive(viewModel.timer) { _ in
                    viewModel.move(in: geometry)
                }
            }
            Spacer()
            
            VStack {
            KeyboardView(direction: $viewModel.direction)
                .padding()
                Button {
                    viewModel.autoPilot.toggle()
                } label: {
                    Text(viewModel.autoPilot ? "Stop autopilot" : "Start autopilot")
                        .frame(alignment: .trailing)
                }

            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: .default(alertItem.buttonTitle, action: {
                viewModel.gameRunning = true
                viewModel.reset()
            }))
        }
    }
}

struct GameViewPreview: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

