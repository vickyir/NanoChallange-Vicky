//
//  MainView.swift
//  Itambah
//
//  Created by Vicky Irwanto on 03/04/23.
//

import SwiftUI

struct MainView: View {
    @State var myDice = 1
    @State private var dots : [[Int]] = [[1,2,3], [4,5,6], [7,8,9], [10,11,12]]
    @State var val1 = "?"
    @State var val2 = "?"
    @State var result = ""
    @State private var finalCount =  false
    @State var hintBtn = false
    @State private var dotsCount: [Int] = []
    @State private var currentDice = 0
    @State private var SplashScreen = false
    @State private var checkTrue =  false
    @State private var checkTrue2 =  false
    @State private var checkFalse = false
    @State private var checkCorrect = false
    var body: some View {
        if SplashScreen{
            splashDice(dice: $myDice, Val1: $val1, Val2: $val2, splash: $SplashScreen, check1: $checkTrue)
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
                            .scaledToFill()
                            .onTapGesture {
                                self.hintBtn = false
                                self.SplashScreen = true
                            }
                        Text(val1)
                            .font(.system(size: 140, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("SecondColor"))
                            .shadow(radius: 2, x: 2, y: 2)
                            .scaledToFill()
                        Image("Tambah")
                        Text(val2)
                            .font(.system(size: 140, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("SecondColor"))
                            .shadow(radius: 2, x: 2, y: 2)
                            .scaledToFill()
                        Image("Sama Dengan")
                        TextField("?", text: $result)
                            .frame(width: 151, height: 151)
                            .multilineTextAlignment(TextAlignment.center)
                            .font(.system(size: 120, weight: .semibold, design: .rounded))
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("SecondColor"), lineWidth: 6)
                            }
                            .foregroundColor(Color("SecondColor"))
                            .scaledToFill()
                    }
                    
                    HStack{
                     
                        VStack(spacing: 0.0){
                            ForEach(dots.indices, id: \.self){
                                rowIndex in
                                HStack{
                                    ForEach(dots[rowIndex].indices, id: \.self){
                                        columnIndex in
                                        Image("Circle 1")
                                            .onTapGesture {
                                                withAnimation{
                                                    if((val2 != "?") && (val1 != "?") && (checkTrue == true)){
                                                        removeDots(at: (rowIndex, columnIndex))
                                                        dotsCount.append(dotsCount.count + 1)
                                                    }
                                                    else if val1 != "?" && checkTrue == false{
                                                        removeDots(at: (rowIndex, columnIndex))
                                                        dotsCount.append(dotsCount.count + 1)
                                                    }else{
                                                        self.hintBtn = true
                                                    }
                                                    
                                            
                                                }
                                            }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        .padding(.leading, 22)
                        
                        Spacer()
                
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 17)
                                    .frame(width: 498, height: 46)
                                    .foregroundColor(Color("SecondColor"))
                                    .shadow(radius: 4, x: 2, y: 2)
                                HStack{
                                    withAnimation{
                                        ForEach(dotsCount, id: \.self){
                                            _ in
                                            Circle()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(Color("Purple"))
                                                .shadow(radius: 2, x: 2, y:2)
                                        }
                                    }
                                   
                                }
                                
                                
                            }
                           
                               
                            Button(action: {
                                if val1 != "?" {
                                    if checkTrue == true{
        
                                        self.finalCount = checkResult(Int(result) ?? 0, dotsCount.count )
                                        
                                        if finalCount == false {
                                            self.checkFalse = true
                                        }else  {
                                            self.checkCorrect = true
                                        }
                                    }else{
                                        self.checkTrue = checkDots(Int(val1) ?? 0, dotsCount.count)
                                        
                                        if checkTrue == false {
                                            self.checkFalse = true
                                        }else  {
                                            self.checkCorrect = true
                                        }
                                    }
                                   
                                    
                                   
                                }
                                
                            }, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 498, height: 29)
                                        .foregroundColor(Color("MainBlue"))
                                        .shadow(radius: 4, x: 2, y: 2)
                                    Text("Cek")
                                        .foregroundColor(Color("SecondColor"))
                                    
                                        
                                }
                                
                            })

                        }
                        Spacer()
                        Spacer()
                        
                        
                    }
                }
                
                
                if ((checkTrue != true || finalCount != true) && (checkFalse == true)){
                    ZStack{
                        RoundedRectangle(cornerRadius: 0)
                            .ignoresSafeArea()
                            .foregroundColor(Color("PrimaryColor"))
                            .opacity(0.8)
                            .blur(radius: 10)
                        Circle()
                            .frame(width: 201, height: 201)
                            .foregroundColor(Color("SecondColor"))
                            .shadow(radius: 4, x: 2, y: 2)
                        Image(systemName: "xmark")
                            .font(.system(size: 100, weight: .bold, design: .rounded))
                            .foregroundColor(Color("ThirdColor"))
                            .shadow(radius: 2, x: 2, y: 2)
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        withAnimation {
                                            self.checkFalse = false
                                        }
                                    }
                    }
                   
                }
                
                if ((checkTrue == true || finalCount == true) && checkCorrect == true) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 0)
                            .ignoresSafeArea()
                            .foregroundColor(Color("PrimaryColor"))
                            .opacity(0.8)
                            .blur(radius: 10)
                        Circle()
                            .frame(width: 201, height: 201)
                            .foregroundColor(Color("SecondColor"))
                            .shadow(radius: 4, x: 2, y: 2)
                        Image(systemName: "checkmark")
                            .font(.system(size: 100, weight: .bold, design: .rounded))
                            .foregroundColor(Color("ThirdColor"))
                            .shadow(radius: 2, x: 2, y: 2)
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        withAnimation {
                                            self.checkCorrect = false
                                        }
                                    }
                    }
                }
               
            }
        }
     
        
    }
    
    func removeDots(at index: (row: Int, cols: Int)){
        dots[index.row].remove(at: index.cols)
    }
    
    func checkDots(_ val1: Int, _ theDots: Int)-> Bool{
        if val1 == theDots{
            return true
        }else{
            return false
        }
    }
    
    func checkResult(_ result: Int, _ resultDots: Int)-> Bool{
        if result == resultDots{
            return true
        }else{
            return false
        }
    }
    
    
}

struct splashDice: View{
    @Binding var dice: Int
    @Binding var Val1: String
    @Binding var Val2: String
    @Binding var splash: Bool
    @Binding var check1: Bool
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    var body: some View{
        ZStack{
            Rectangle()
                .blur(radius: 5)
                .ignoresSafeArea()
                .foregroundColor(Color("PrimaryColor"))
            Image("Star 1")
                .offset(y:205)
                .blur(radius: 5)
            Image("Star 2")
                .offset(x:300, y: -70)
                .blur(radius: 5)
            Image("Star 3")
                .offset(x: -400, y: 75)
                .blur(radius: 5)
            Image("Big Dice \(dice)")
        }
        .onReceive(timer){ _ in
            DispatchQueue.main.async {
                withAnimation {
                    dice = Int.random(in: 1...6)
                    
                }
                
            }
            
        }
        
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                if Val1 == "?" || check1 == false{
                                    self.Val1 = "\(dice)"
                                }
                                
                                if Val1 != "?" && check1 == true{
                                    self.Val2 = "\(dice)"
                                }
                              
                                self.splash = false
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
