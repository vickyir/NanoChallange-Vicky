//
//  HomeView.swift
//  Itambah
//
//  Created by Vicky Irwanto on 03/04/23.
//

import SwiftUI

struct HomeView: View {
    @State var changeView = false
    var body: some View {
        return Group{
            if changeView{
                ParentView()
            }else{
                ZStack{
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(Color("PrimaryColor"))
                    Image("Star 1")
                        .offset(y:205)
                    Image("Star 2")
                        .offset(x:300, y: -70)
                    Image("Star 3")
                        .offset(x: -400, y: 75)
                    VStack(spacing: 0.0){
                        
                        Text("iTambah-Tambah")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .foregroundColor(Color("SecondColor"))
                        Text("by Chuakz Lab Inc.")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(Color("SecondColor"))
                            .padding(.bottom, 36.0)
                        Button(action:{
                            withAnimation{
                                self.changeView.toggle()
                                
                            }
                           
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 78, height: 29)
                                    .foregroundColor(Color("SecondColor"))
                                    .shadow(radius: 4, x: 2, y: 2)
                                Text("Mulai")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("ThirdColor"))

                                    
                            }
                            
                        })
                    
                    }
                }
                .onAppear{
                    SoundManager.instance.PlaySound()
                }
            }
        }
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
