//
//  MainView.swift
//  Itambah
//
//  Created by Vicky Irwanto on 03/04/23.
//

import SwiftUI

struct MainView: View {
    @State var myDice = 0
    @State var val1 = "?"
    @State var val2 = "?"
    @State var result = ""
    @State var hintBtn = false
    var body: some View {
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
                HStack{
                    Spacer()
                    ZStack{
                        if hintBtn{
                            RoundedRectangle(cornerRadius:8)
                                .frame(width: 340, height: 41)
                                .foregroundColor(Color("SecondColor"))
                            Text("Tekan Dadu Untuk Memulai")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        
                    }
                    .cornerRadius(8)
                    Spacer()
                    Image("Hint")
                        .onTapGesture {
                            withAnimation{
                                self.hintBtn.toggle()
                                print(hintBtn)
                            }
                            
                        }
                    Image("Pause")
                       
                }
                .padding(.bottom, 15.0)
                
                HStack(spacing: 20){
                    Image("Dice 1")
                    Text(val1)
                        .font(.system(size: 140, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("SecondColor"))
                        .shadow(radius: 2, x: 2, y: 2)
                    Image("Tambah")
                    Text(val2)
                        .font(.system(size: 140, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("SecondColor"))
                        .shadow(radius: 2, x: 2, y: 2)
                    Image("Sama Dengan")
                    TextField("?", text: $result)
                        .frame(width: 171, height: 171)
                        .multilineTextAlignment(TextAlignment.center)
                        .font(.system(size: 140, weight: .semibold, design: .rounded))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("SecondColor"), lineWidth: 6)
                        }
                        .foregroundColor(Color("SecondColor"))
                }
                
                HStack{
                    
                }
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
