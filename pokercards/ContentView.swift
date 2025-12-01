//  ContentView.swift
//  pokercards
//
//  Created by Abdallah Kamash on 1/12/2025.
//

import SwiftUI

extension Color {
    static var invertedPrimary: Color {
        // Convert Color.primary to UIColor
        let uiColor = UIColor { trait in
            trait.userInterfaceStyle == .dark ? .white : .black
        }
        
        // Invert it
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return Color(
            red: 1-red,
            green: 1-green,
            blue: 1-blue,
            opacity: Double(alpha)
        )
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorSheme: ColorScheme
    @State private var xd = 0.0
    @State private var yd = 0.0
    @State private var zd = 0.0
    @State private var tapped = false
    
    var body: some View {
        ZStack {
            Image("pattern").resizable()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(x: tapped ? 5 : 0, y: tapped ? 5 : 0).opacity(0.2)
            RoundedRectangle(cornerRadius: 15).foregroundStyle(
                Color.invertedPrimary
            ).overlay {
                RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5)
            }
            .overlay(alignment: .topLeading) {
                HStack(alignment: .center) {
                    Text("A")
                        .font(.custom("Pixelify Sans", size: 35))
                    Image(systemName: "circle.fill")
                }.padding(.horizontal, 15)
                    .padding(.vertical, 5)
            }
            .overlay(alignment: .bottomTrailing) {
                HStack(alignment: .center) {
                    Text("A")
                        .font(.custom("Pixelify Sans", size: 35))
                    Image(systemName: "circle.fill")
                }.padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .rotationEffect(.degrees(180))
            }
            ZStack(alignment: .bottom) {
                ForEach(0..<6) { i in
                    let size = 220 - (i * 15)
                    Circle()
                    
                        .frame(
                            width: tapped ? CGFloat(size) : 220,
                            alignment: .bottom
                        )
                        .opacity(tapped ? 1 : i == 0 ? 1 : 0)
                        .foregroundStyle(
                            .primary.opacity(tapped ? CGFloat(i) * 0.15 : 1)
                        )
                        .overlay {
                            Circle()
                                .stroke(
                                    lineWidth: tapped ? 0.5 : i == 0 ? 0.5 : 0
                                )
                        }
                    
                }
            }.scaleEffect(x: tapped ? 1.55 : 1, y: tapped ? 1.2 : 1).offset(
                x: 100,
                y: -10
            )   .frame(height: 300)     .clipped()
            
        }
        .frame(width: 200, height: 325)
        .scaleEffect(tapped ? 1 : 1.75)
        .rotation3DEffect(
            Angle(degrees: zd),
            axis: (x: 0.0, y: 0, z: 1.0),
            perspective: 0.5
        )
        .rotation3DEffect(
            Angle(degrees: xd),
            axis: (x: 1.0, y: 0, z: 0.0),
            perspective: 0.25
        )
        .onTapGesture {
            withAnimation(.bouncy(duration: 5)) {
                tapped.toggle()
                
                if tapped {
                    xd = 45
                    yd = 30
                    zd = 60
                    
                } else {
                    xd = 0
                    yd = 0
                    zd = 0
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
