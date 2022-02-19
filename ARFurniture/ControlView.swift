//
//  ControlView.swift
//  ARFurniture
//
//  Created by KANISHK VIJAYWARGIYA on 18/01/22.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControlsVisible: Bool
    @Binding var showBrowse: Bool
    
    var body: some View {
        VStack {
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            Spacer()
            
            if isControlsVisible {
                ControlButtonBar(showBrowse: $showBrowse)
            }
        }
    }
}

struct ControlVisibilityToggleButton: View {
    @Binding var isControlsVisible: Bool
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Color.black.opacity(0.25)
                ControlButton(systemIconName: self.isControlsVisible ? "rectangle" : "slider.horizontal.below.rectangle", iconSize: 25) {
                    self.isControlsVisible.toggle()
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8)
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
}

struct ControlButtonBar: View {
    @Binding var showBrowse: Bool
    
    var body: some View {
        HStack {
            // most recently placed button
            ControlButton(systemIconName: "clock.fill", iconSize: 35) {
                
            }
            
            Spacer()
            
            // browse button
            ControlButton(systemIconName: "square.grid.2x2", iconSize: 35) {
                self.showBrowse.toggle()
            }
            .sheet(isPresented: $showBrowse) {
                // Browse View
                BrowseView(showBrowse: $showBrowse)
            }
            
            Spacer()
            
            // settings button
            ControlButton(systemIconName: "slider.horizontal.3", iconSize: 35) {
                
            }
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
}

struct ControlButton: View {
    @StateObject var vm = HapticViewModel()
    let systemIconName: String
    let iconSize: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            vm.impact(style: .heavy)
            vm.haptic(type: .success)
            self.action()
        }) {
            Image(systemName: systemIconName)
                .font(.system(size: iconSize))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 50, height: 50)
    }
}
