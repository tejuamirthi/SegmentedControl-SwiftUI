//
//  SwiftUIView.swift
//  SegmentedControl-SwiftUI
//
//  Created by Amirthy Tejeshwar on 30/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//


import SwiftUI

struct Segment {
    var title: String?
    var image: String?
    
    init(title: String?, image: String? = nil) {
        self.title = title
        self.image = image
    }
}

public struct Segments {
    public init() {
        
    }
    var data: [Segment] = [
    .init(title: "Title 1"),
    .init(title: "Title 2"),
    .init(title: "Very large title 3"),
    .init(title: "Can't imagine this long title"),
        .init(title: "5th title too long")
    ]
}

public struct SegmentedControlView: View {
    
    var segments: Segments = Segments()
    @State var selectedIndex = 0
    @Namespace var animation
    
    public init() {
        
    }
    
    public var body: some View {
        return NavigationView {
            VStack {
                ScrollViewReader { scrollView in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<self.segments.data.count) { index in
                                RowDataView(selectedIndex: $selectedIndex, index: index, data: self.segments.data[index], animation: animation)
                                .id(index)
                            }
                        }.aspectRatio(contentMode: ContentMode.fill)
                    }
                    .onChange(of: selectedIndex) { index in
                        withAnimation {
                            scrollView.scrollTo(index)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct RowDataView: View {
    @Binding var selectedIndex: Int
    let index: Int
    let data: Segment
    let animation: Namespace.ID
    
    
    var body: some View {
        let view: some View = RoundedRectangle(cornerRadius: 16)
            .stroke(Color.black, lineWidth: 2)

        return Button(action: {
            withAnimation {
                selectedIndex = index
            }
            }) {
                ZStack {
                    if selectedIndex == index {
                        Text(data.title ?? "Hey ya")
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .matchedGeometryEffect(id: /*@START_MENU_TOKEN@*/"ID"/*@END_MENU_TOKEN@*/, in: animation)
                    } else {
                        Text(data.title ?? "Hey ya")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(16)
                            .overlay(view)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
    }
}

struct SegmentedControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlView()
    }
}


public extension View {

    func `if`<Content: View>(_ conditional: Bool, trueContent: ((Self) -> Content)? = nil, falseContent: ((Self) -> Content)? = nil) -> some View {
        if conditional, let content = trueContent {
            return AnyView(content(self))
        } else if !conditional, let fContent = falseContent {
            return AnyView(fContent(self))
        }
        return AnyView(self)
    }
}
