//
//  BrowseView.swift
//  ARFurniture
//
//  Created by KANISHK VIJAYWARGIYA on 18/01/22.
//

import SwiftUI

struct BrowseView: View {
    @Binding var showBrowse: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                // grid views for thumbnails
                ModelsByCategoryGrid(showBrowse: $showBrowse)
            }
            .navigationBarTitle(Text("Browse"), displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showBrowse.toggle()
                    }) {
                        Text("Done").bold()
                    }
                }
            }
        }
    }
}

struct ModelsByCategoryGrid: View {
    @Binding var showBrowse: Bool
    let models = Models()
    
    var body: some View {
        VStack {
            ForEach(ModelCategory.allCases, id: \.self) { category in
                // only display grid if category contains items
                if let modelsByCategory = models.get(category: category) {
                    HoriozontalGrid(title: category.label, items: modelsByCategory, showBrowse: $showBrowse)
                }
            }
        }
    }
}

struct HoriozontalGrid: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    var title: String
    var items: [Model]
    private let gridItemLayout = [GridItem(.fixed(150))]
    @Binding var showBrowse: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Separator()
            
            Text(title)
                .font(.title2.bold())
                .padding(.leading, 22)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(0..<items.count) { index in
                        let model = items[index]
                        ItemButton(model: model) {
                            //TODO: call model method to async load modalEntity
                            model.asyncLoadModelEntity()
                            
                            //TODO: select model for placement
                            self.placementSettings.selectedModel = model
                            
                            print("Browse View: selected \(model.name) for placement.")
                            self.showBrowse = false
                        }
//                        Color(UIColor.secondarySystemFill)
//                            .frame(width: 150, height: 150)
//                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
            }
        }
    }
}

struct ItemButton: View {
    @StateObject var vm = HapticViewModel()
    let model: Model
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            vm.impact(style: .heavy)
            vm.haptic(type: .success)
            self.action()
        }) {
            Image(uiImage: self.model.thumbnail)
                .resizable()
                .frame(height: 150)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color(UIColor.secondarySystemFill))
                .cornerRadius(8)
        }
    }
}

struct Separator: View {
    var body: some View {
        Divider()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}
