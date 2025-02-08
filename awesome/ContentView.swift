//
//  ContentView.swift
//  awesome
//
//  Created by dingstock on 2025/2/8.
//

import Charts
import SwiftUI


import SplineRuntime
import SwiftUI

struct ContentView: View {
    var body: some View {
        // fetching from cloud
        let url = URL(string: "https://build.spline.design/d9ZCPsohRo4em4PQzklX/scene.splineswift")!

//        SplineView(sceneFileURL: url).ignoresSafeArea(.all)
        ActivityView()
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
