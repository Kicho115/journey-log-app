//
//  LogDetailView.swift
//  JourneyLog
//
//  Created by CETYS Universidad  on 24/02/25.
//

import SwiftUI
import MapKit

struct LogDetailView: View {
    var log: Log
    
    var body: some View{
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(log.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(12)
                    .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Descripción de entrada")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Text(log.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding()
                
                    // Mostrar la ubicación utilizando un mapa:
                    if let latitude = log.location.latitude, let longitude = log.location.longitude {
                        Map(
                            // MARK: Agregar codigo aqui como en la presentacion
                        )
                        ))
                        .frame(height: 200)
                    }
                    
                }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.2))
        .navigationTitle("Task Details")
    }
}

#Preview {
    LogDetailView(log: Task(title: "Ejemplo", description: "Ejemplo de una descripcion")
    )
}
