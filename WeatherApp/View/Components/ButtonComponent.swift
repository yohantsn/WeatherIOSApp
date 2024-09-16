//
//  ButtonComponent.swift
//  WeatherApp
//
//  Created by CTW02177-Admin on 16/09/2024.
//

import Foundation
import SwiftUI

struct ButtonComponent: View {
    let isLoading: Bool
        let text: String
        let onTap: () -> Void
    var body: some View {
            HStack(alignment: .center, spacing: 10) {
                
                Text(text.uppercased())
                    .padding(.vertical, 12)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity, alignment: .center)
            .background( .blue.opacity(0.5))
            .cornerRadius(6)
            .onTapGesture {
                isLoading ? nil : onTap()
            }
        }
}

struct ButtonView_Preview: PreviewProvider {
    static var previews: some View{
        ButtonComponent(
            isLoading: false, text: "Refresh") {
                
            }.padding(.horizontal, 20)
    }
}
