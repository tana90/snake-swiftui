//
//  KeyView.swift
//  Snake-swiftUI
//
//  Created by Tudor Octavian Ana on 16.01.2022.
//

import SwiftUI

struct KeyView: View {
    
    var imageName: String = "chevron.up"
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 88)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.red)
                .shadow(radius: 4)
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 33, height: 33)
                .foregroundColor(.white)
                .shadow(radius: 2)
        }
    }
}

struct KeyView_Preview: PreviewProvider {
    static var previews: some View {
        KeyView()
    }
}
