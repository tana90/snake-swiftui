//
//  KeyboardView.swift
//  Snake-swiftUI
//
//  Created by Tudor Octavian Ana on 16.01.2022.
//

import SwiftUI

struct KeyboardView: View {
    
    @Binding var direction: Direction
    
    var body: some View {
        VStack {
            HStack {
                KeyView(imageName: "chevron.up")
                    .onTapGesture {
                        if direction != .down {
                            direction = .up
                        }
                    }
            }
            HStack {
                KeyView(imageName: "chevron.left")
                    .onTapGesture {
                        if direction != .right {
                            direction = .left
                        }
                    }
                KeyView(imageName: "chevron.down")
                    .onTapGesture {
                        if direction != .up {
                            direction = .down
                        }
                    }
                KeyView(imageName: "chevron.right")
                    .onTapGesture {
                        if direction != .left {
                            direction = .right
                        }
                    }
            }
        }
        .frame(height: 166, alignment: .bottom)
        .aspectRatio(contentMode: .fit)
    }
}

struct KeyboardView_Preview: PreviewProvider {
    static var previews: some View {
        KeyboardView(direction: .constant(.right))
    }
}
