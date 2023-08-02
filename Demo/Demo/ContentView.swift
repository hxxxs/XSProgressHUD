//
//  ContentView.swift
//  Demo
//
//  Created by LL on 2023/8/2.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var state: ProgressState
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                state.show(title: "这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息这是一条提示信息")
            } label: {
                Text("Show Txt")
                    .padding()
            }
            
            Button {
                state.show(type: .error, title: "这是一条错误提示信息")
            } label: {
                Text("Show Error")
                    .padding()
            }
            
            Button {
                state.show(type: .image, title: "图片信息提示", image: Image(systemName: "person"))
            } label: {
                Text("Show Image")
                    .padding()
            }
            
            Button {
                state.show(type: .success, title: "这是一条正确信息")
            } label: {
                Text("Show Success")
                    .padding()
            }
            
            Button {
                state.show(type: .loading, title: "loading...")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    state.hide()
                }
            } label: {
                Text("Show loading")
                    .padding()
            }
            
            Button {
                state.hide()
            } label: {
                Text("Hide loading")
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
