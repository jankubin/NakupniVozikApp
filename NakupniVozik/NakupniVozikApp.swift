//
//  NakupniVozikApp.swift
//  NakupniVozik
//
//  Created by Jan Kubín on 01.06.2023.
//

import SwiftUI

@main
struct NakupniVozikApp: App {
    
    @StateObject private var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            FirstView()
                .environmentObject(vm)
        }
    }
}

