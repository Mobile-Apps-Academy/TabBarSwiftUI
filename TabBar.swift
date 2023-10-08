//
//  Home.swift
//  BottomTabBar
//
//  Created by Javid Shaikh on 07/10/23.
//

import SwiftUI

var tabs = ["square.and.arrow.up.circle.fill", "pencil.circle.fill", "trash.circle.fill", "paperplane.circle.fill"]

struct Home: View {
    
    @State var selectedTab = "square.and.arrow.up.circle.fill"
    
    @Namespace var animation
    @State var xAxis: CGFloat = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                Color(.red)
                    .ignoresSafeArea()
                    .tag("square.and.arrow.up.circle.fill")
                
                Color(.cyan)
                    .ignoresSafeArea()
                    .tag("pencil.circle.fill")
                
                Color(.gray)
                    .ignoresSafeArea()
                    .tag("trash.circle.fill")
                
                Color(.blue)
                    .ignoresSafeArea()
                    .tag("paperplane.circle.fill")
            }
            CustomTabBar()
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        VStack(alignment: .center) {
            HStack {
                ForEach(tabs, id: \.self) { image in
                    GeometryReader { reader in
                        
                        Button {
                            withAnimation(Animation.interactiveSpring(dampingFraction: 2)) {
                                selectedTab = image
                                xAxis = reader.frame(in: .global).midX
                            }
                            
                        } label: {
                            Image(systemName: image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(image == selectedTab ? getIconColor(image: image) : Color.black)
                                .background(Color.white.opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.white, lineWidth: 4)
                                }
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: 0 , y: selectedTab == image ? -40 : 0)
                                .foregroundStyle(.blue)
                        }
                        .onAppear{
                            if image == tabs.first {
                                xAxis = reader.frame(in: .global).midX
                            }
                        }

                        
                    }
                    .frame(width: 60, height: 60)
                    
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.clipShape(CustomTabBarShape(xAxis: xAxis)))
    }
    
    func getIconColor(image: String) -> Color {
        switch image {
        case "square.and.arrow.up.circle.fill":
            return Color.red
        case "pencil.circle.fill":
            return Color.cyan
        case "trash.circle.fill":
            return Color.gray
        case "paperplane.circle.fill":
            return Color.blue
        default:
            return Color.red
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
