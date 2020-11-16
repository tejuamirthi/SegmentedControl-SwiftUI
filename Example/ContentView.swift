//
//  ContentView.swift
//  Example
//
//  Created by Amirthy Tejeshwar on 31/10/20.
//  Copyright © 2020 Amirthy Tejeshwar. All rights reserved.
//

import SwiftUI
import SegmentedControl_SwiftUI

struct ContentView: View {
    var body: some View {
        SegmentedControlView(list: ["Title", "Segments","Title3", "Title4", "Title5"])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
