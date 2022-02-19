//
//  PlacementSettings.swift
//  ARFurniture
//
//  Created by KANISHK VIJAYWARGIYA on 20/01/22.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    // when the user selects a model in browse view, this property is set
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("Setting selected model to \(String(describing: newValue?.name))")
        }
    }
    
    // when the user taps confirm in placement view, the value of selected model is assigned to confirmed model
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmed model")
                return
            }
            print("Setting confirmed to \(model.name)")
        }
    }
    
    // this property retains the cancellable object for our SceneEvents.update subscriber
    var sceneObserver: Cancellable?
}
