//
//  Model.swift
//  ARFurniture
//
//  Created by KANISHK VIJAYWARGIYA on 20/01/22.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    //case table
case chair
case decor
    //case light
case wearables
    
    var label: String {
        get {
            switch self {
                //            case .table:
                //                return "Tables"
            case .chair:
                return "Chairs"
            case .decor:
                return "Decors"
                //            case .light:
                //                return "Lights"
            case .wearables:
                return "Wearables"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    //TODO: Create a method to asnyc load model entity.
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                switch loadCompletion {
                case .failure(let error): print("Unable to load model entity for the \(filename) Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                print("model entity for \(self.name) has been loaded.")
            })
        
    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        // Tables
        //        let diningTable = Model(name: "dining_table", category: .table, scaleCompensation: 0.32/100)
        //        let familyTable = Model(name: "family_table", category: .table, scaleCompensation: 0.32/100)
        //        self.all += [diningTable, familyTable]
        
        // Chairs
        let diningChair = Model(name: "chairs", category: .chair, scaleCompensation: 0.6)
        self.all += [diningChair]
        
        // Decors
        let cupSaucerSet = Model(name: "cup_saucer_set", category: .decor)
        let teaPot = Model(name: "teapot", category: .decor, scaleCompensation: 0.4)
        let flowerTulip = Model(name: "flower_tulip", category: .decor, scaleCompensation: 0.4)
        let toyCar = Model(name: "toy_car", category: .decor, scaleCompensation: 1)
        let guitar = Model(name: "fender_stratocaster", category: .decor, scaleCompensation: 1)
        let gramoPhone = Model(name: "gramophone", category: .decor, scaleCompensation: 0.2)
        let slide = Model(name: "slide_stylized", category: .decor, scaleCompensation: 0.3)
        let drummer = Model(name: "toy_drummer", category: .decor, scaleCompensation: 1)
        let robot = Model(name: "toy_robot_vintage", category: .decor, scaleCompensation: 1)
        let tv = Model(name: "tv_retro", category: .decor, scaleCompensation: 0.6)
        let wateringCan = Model(name: "wateringcan", category: .decor, scaleCompensation: 0.6)
        self.all += [cupSaucerSet, teaPot, flowerTulip, toyCar, guitar, gramoPhone, slide, drummer, robot, tv, wateringCan]
        
        // Lights
        //        let floorLampClassic = Model(name: "floor_lamp_classic", category: .light, scaleCompensation: 0.32/100)
        //        let floorLampModern = Model(name: "floor_lamp_modern", category: .light, scaleCompensation: 0.32/100)
        //        self.all += [floorLampClassic, floorLampModern]
        
        // Wearables
        let shoe = Model(name: "shoes", category: .wearables)
        self.all += [shoe]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter({$0.category == category})
    }
}
