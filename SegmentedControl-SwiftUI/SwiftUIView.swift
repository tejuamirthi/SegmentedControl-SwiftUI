//
//  SwiftUIView.swift
//  SegmentedControl-SwiftUI
//
//  Created by Amirthy Tejeshwar on 30/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//


import SwiftUI

struct SegmentData: Identifiable {
    var id = UUID()
    var title: String?
    var isSelected: Bool?
    var image: String?
    
    init(title: String?, isSelected: Bool = false, image: String? = nil) {
        self.title = title
        self.isSelected = isSelected
        self.image = image
    }
}

class SegmentDataViewModel: ObservableObject {
    @Published var data: [SegmentData] = [
    .init(title: "Title 1"),
    .init(title: "Title 2"),
    .init(title: "Very large title 3"),
    .init(title: "Can't imagine this long title")
    ]
}


struct SegmentedControlView: View {
    // let data: [String] = ["one", "Big big biiiiggg two", "three", "Very bery big four cant imagine big"]
//    @State var isSelected: [Bool] = [true, false, true, false]
    
    @ObservedObject var segmentDataVM: SegmentDataViewModel = SegmentDataViewModel()
    var body: some View {
        VStack {

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
//                    ForEach(Array(zip(data, isSelected)), id: \.0) { item in
//                        RowDataView(item: item.0, isSelected: item.1)
//                    }
                    ForEach(segmentDataVM.data.indices) { index in
                        RowDataView(item: index, data: self.segmentDataVM.data)
                    }
                }.aspectRatio(contentMode: ContentMode.fill)
            }
            Text("This is supposed to be body")
            Spacer()
        }
        .edgesIgnoringSafeArea(Edge.Set())
    }
}

struct RowDataView: View {
    var segmentData: [SegmentData]
    let index: Int
    
    init(item: Int, data: [SegmentData]) {
        segmentData = data
        index = item
    }
    
    var body: some View {
//        Text(item)
         let view: some View = RoundedRectangle(cornerRadius: 16)
            .stroke(Color.black, lineWidth: 2)
            
        return Button(action: {
//            self.segmentData[self.index].isSelected?.toggle()
        }) {
            Text(segmentData[index].title ?? "Hey ya")
        }
        
//        return Text(item)
            .padding()
            .if(segmentData[index].isSelected ?? false, trueContent: {
                $0.background(Color.black)
                .foregroundColor(.white)
                }, falseContent: {
                    $0.background(Color.white)
                .foregroundColor(.black)
                })
            .cornerRadius(16)
            .if(!(segmentData[index].isSelected ?? false), trueContent: {
                $0.overlay(view)
            })
    .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
        
        
        
        
        
        //.background(Color.blue.overlay(view))
//            .overlay(view)
            
            
        
//        RoundedRectangle(cornerRadius: 25.0).fill(Color.blue)
//            .aspectRatio(2.5, contentMode: .fit)
//            .overlay(
//                Text(item)
//            )
        
    }
}

//struct RowDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        RowDataView(item: "Heylo")
//    }
//}

struct SegmentedControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlView()
    }
}


extension View {

    func `if`<Content: View>(_ conditional: Bool, trueContent: ((Self) -> Content)? = nil, falseContent: ((Self) -> Content)? = nil) -> some View {
        if conditional, let content = trueContent {
            return AnyView(content(self))
        } else if !conditional, let fContent = falseContent {
            return AnyView(fContent(self))
        }
        return AnyView(self)
    }
}
