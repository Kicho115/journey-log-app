//
//  HomeView.swift
//  JourneyLog
//
//  Created by CETYS Universidad  on 24/02/25.
//

import SwiftUI

struct HomeView: View {
    @State private var Logs: [Log] = []
    
    @State private var showAddLogView: Bool = false
    
    var body : some View {
        NavigationView {
            List {
                ForEach(Logs) { log in
                    NavigationLink(destination: LogDetailView(log: log)) {
                        Text(log.title)
                    }
                }
                .onDelete(perform: deleteLog)
            }
            .navigationBarTitle("Journey Logs", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showAddLogView = true
                    }) {
                        Image(SystemName: "plus")
                    }
                }
        }
    }
    }
}

func deleteLog(at offsets: IndexSet) {
    Logs.remove(atOffsets: offsets)
}

/*#Preview {
    HomeView()
}*/
