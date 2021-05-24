//
//  components.swift
//  unigraph
//
//  Created by Jann Driessen on 21.05.21.
//

import SwiftUI

struct FilterView: View {
    var arrowUp: Bool
    var selected: Bool
    var selectedColor: Color
    var title: String

    var body: some View {
        let highlightColor = selected ? selectedColor : .gray
        
        return (
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(selected ? .gray.opacity(0.1) : Color.white)
                HStack {
                    Text(title)
                        .bold()
                        .foregroundColor(highlightColor)
                        .font(.caption)
                    if selected {
                        Image(systemName: arrowUp ? "arrow.up" : "arrow.down")
                            .font(Font.system(.caption).bold())
                            .foregroundColor(selectedColor)
                            .padding(.leading, -4)
                    }
                }
                .padding(8)
            }
        )
    }
}

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
    var detail: String

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
            ListItemDetail(color: highlightColor, text: detail)
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
        .padding(.vertical, 8)
    }
}

struct components_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                FilterView(arrowUp: true, selected: true, selectedColor: .purple, title: "Pool size")
                FilterView(arrowUp: false, selected: true, selectedColor: .blue, title: "Pool size")
                FilterView(arrowUp: true, selected: false, selectedColor: .purple, title: "24h volume")
            }
            .frame(height: 32)
            .padding(16)
            .padding(.bottom, 32)
            ListItemView(title: "USDC-ETH", subtitle: "UNI-V2", detail: "$759.20m")
        }
    }
}
