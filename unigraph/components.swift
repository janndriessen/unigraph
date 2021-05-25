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

struct ListCell: View {
    var title: String
    var subtitle: String
    var body: some View {
        HStack {
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 44)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray.opacity(0.8))
            }
            Spacer()
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
    }
}

struct ListFilter: View {
    var selected: Bool
    var title: String

    var body: some View {
        let highlightColor: Color = selected ? .gray : .gray.opacity(0.7)

        return (
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(selected ? .gray.opacity(0.1) : Color.white)
                HStack {
                    Text(title)
                        .bold()
                        .foregroundColor(highlightColor)
                        .font(.caption)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            }
        )
    }
}

struct ListFilterView: View {
    var lists: [List]
    @Binding var selectedListId: UUID?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                ForEach(lists, id: \.id) { list in
                    ListFilter(selected: selectedListId == list.id, title: list.title)
                        .animation(.spring())
                        .onTapGesture {
                            let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                            feedbackGenerator.impactOccurred()
                            if selectedListId == list.id {
                                return
                            }
                            selectedListId = list.id
                        }
                }
            }
        }
        .frame(height: 32)
        .padding(.bottom, 4)
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

struct UniswapFilterListView: View {
    var lists: [TokenPairList]
    @Binding var ascending: Bool
    @Binding var selectedListId: UUID?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                ForEach(lists, id: \.id) { list in
                    FilterView(arrowUp: ascending, selected: selectedListId == list.id, selectedColor: list.selectedColor, title: list.title)
                        .animation(.spring())
                        .onTapGesture {
                            let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                            feedbackGenerator.impactOccurred()
                            if selectedListId == list.id {
                                ascending.toggle()
                                return
                            }
                            ascending = false
                            selectedListId = list.id
                        }
                }
            }
        }
        .frame(height: 32)
        .padding(.bottom, 4)
    }
}

struct components_Previews: PreviewProvider {
    @State private static var selectedListId: UUID? = List.lists.first?.id

    static var previews: some View {
        return (
            VStack {
                ListFilterView(lists: List.lists, selectedListId: $selectedListId)
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
        )
    }
}
