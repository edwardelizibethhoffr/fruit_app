//
//  DetailsIconImage.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import SwiftUI

struct DetailsIconImage: View {
    var image: Image
    
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 3)
            .aspectRatio(contentMode: .fit)
            .frame(height: 60)
    }
}

struct DetailsIconImage_Previews: PreviewProvider {
    static var previews: some View {
        DetailsIconImage(image: Image("till-icon-96"))
    }
}
