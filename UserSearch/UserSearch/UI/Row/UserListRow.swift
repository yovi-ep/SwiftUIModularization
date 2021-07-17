//
//  UserListCell.swift
//  Home
//
//  Created by Yovi Eka Putra on 27/06/21.
//

import SwiftUI
import UIComponent

public struct UserListRow: View {
    public let name: String
    public let logoLink: String
    
    public var body: some View {
        ZStack {
            HStack {
                RemoteImage(url: logoLink)
                    .aspectRatio(1/1, contentMode: .fit)
                    .clipShape(Circle(), style: FillStyle())
                    .frame(width: 64)
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                
                Text(self.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
        }
        
        .overlay(
            RoundedRectangle(cornerRadius: 100)
                .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct UserListCell_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(0..<5) { _ in
            UserListRow(name: "Hi..", logoLink: "photo")
                .buttonStyle(PlainButtonStyle())
        }
        .previewLayout(.sizeThatFits)
    }
}
