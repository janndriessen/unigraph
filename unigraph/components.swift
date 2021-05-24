//
//  components.swift
//  unigraph
//
//  Created by Jann Driessen on 21.05.21.
//

import SwiftUI

struct ListItemDetail: View {
    var color: Color
    var text: String

    var body: some View {
        Text(text)
            .font(.system(.headline))
            .bold()
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(color.opacity(0.05))
            )
            .foregroundColor(color)
            .frame(height: 32)
    }
}

struct ListItemView: View {
    var title: String
    var subtitle: String
    var highlightColor: Color = .blue

    var body: some View {
        HStack(alignment: .center) {
            HStack {
                ZStack(alignment: .leading) {
                    Circle()
                        .fill(Color.gray.opacity(0.9))
                        .frame(width: 44)
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 44)
                        .padding(.leading, 32)
                }
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray.opacity(0.8))
                }
            }
            Spacer()
            ListItemDetail(color: highlightColor, text: "$759.20m")
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
        .padding(.vertical, 8)
    }
}

struct components_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(title: "USDC-ETH", subtitle: "UNI-V2")
    }
}
