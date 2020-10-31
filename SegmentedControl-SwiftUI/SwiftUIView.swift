//
//  SwiftUIView.swift
//  SegmentedControl-SwiftUI
//
//  Created by Amirthy Tejeshwar on 30/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//


import SwiftUI

public struct Segment {
    var title: String?
    var image: String?
    var isSelected: Bool?
    
    init(title: String?, isSelected: Bool = false, image: String? = nil) {
        self.title = title
        self.isSelected = isSelected
        self.image = image
    }
}

public struct SegmentsData {
    var selectedIndex: Int {
        didSet {
            items[oldValue].isSelected = false
            items[selectedIndex].isSelected = true
        }
    }
    var items: [Segment]
    
    init(items: [Segment], index: Int) {
        self.items = items
        self.selectedIndex = index
    }
}

public class SegmentDataViewModel: ObservableObject {
    @Published var data = SegmentsData(items: [
    .init(title: "Title 1", isSelected: true),
    .init(title: "Title 2"),
    .init(title: "Very large title 3"),
    .init(title: "Can't imagine this long title")
    ], index: 0)
    
    
    func changeSelected(_ index: Int) {
        data.selectedIndex = index
    }
}


public struct SegmentedControlView: View {
    
    @ObservedObject var segmentDataVM: SegmentDataViewModel = SegmentDataViewModel()
    
    public init() {
        
    }
    
    public var body: some View {
        
            VStack {

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(segmentDataVM.data.items.indices) { index in
                            RowDataView(data: self.segmentDataVM.data.items[index], index: index)
                                .environmentObject(self.segmentDataVM)
                        }
                    }.aspectRatio(contentMode: ContentMode.fill)
                }
                Spacer()
            }
        
    }
}

public struct RowDataView: View {
    
    @EnvironmentObject var vm: SegmentDataViewModel
    
    let index: Int
    
    init(data: Segment, index: Int ) {
        self.index = index
        
    }
    
    func getSegment() -> Segment {
        return vm.data.items[index]
    }
    
    public var body: some View {
         let view: some View = RoundedRectangle(cornerRadius: 16)
            .stroke(Color.black, lineWidth: 2)
            
        return Button(action: {
                self.vm.changeSelected(self.index)
            }) {
                Text(getSegment().title ?? "Hey ya")
            }
            .padding()
            .if(getSegment().isSelected ?? false, trueContent: {
                $0.background(Color.black)
                .foregroundColor(.white)
                }, falseContent: {
                    $0.background(Color.white)
                .foregroundColor(.black)
                })
            .cornerRadius(16)
            .if(!(getSegment().isSelected ?? false), trueContent: {
                $0.overlay(view)
            })
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
