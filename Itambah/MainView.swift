//
//  MainView.swift
//  Itambah
//
//  Created by Vicky Irwanto on 03/04/23.
//

import SwiftUI

struct MainView: View {
    @State private var backHome =  false
    @State var myDice = 1
    @State var theDice = 1
    @State private var dots : [[Int]] = [[1,2,3], [4,5,6], [7,8,9], [10,11,12]]
    @State var val1 = "?"
    @State var intVal1: Int = 0
    @State var val2 = "?"
    @State var intVal2: Int = 0
    @State var result: Int?
    @State private var hintInformation = ""
    @State private var finalCount =  false
    @State var hintBtn = true
    @State var soundBtn = true
    @State private var dotsCount: [Int] = []
    @State private var dotsCountLap1 : Int = 0
    @State private var currentDice = 0
    @State private var splashScreen = false
    @State private var checkTrue =  false
    @State private var checkTrue2 =  false
    @State private var checkFalse = false
    @State private var checkCorrect = false
    
    @State var isDiceClickable = true //should be true as it's the first stage
    @State var isDotsClickable = false
    @State var isCekClickable = false
    @State var isAnswerClickable = false
    
    @State private var currentStage: Int = 0
    
    @State private var isDiceGlow: Bool = false
    @State private var isDotsGlow: Bool = false
    @State private var isAnswerGlow: Bool = false
    /*
     currentStage:
     0. Click the dice -> isDiceClickable true
     1. Click the dots / dots frame / Cek -> isDotsClickable & isCekClickable true
     2. Click the dice -> isDiceClickable true
     3. Click the dots / dots frame / Cek -> isDotsClickable & isCekClickable true
     4. Click answer -> isAnswerClickable & isCekClickable true
     
     if currentStage == 1 || currentStage == 3 || currentStage == 4{
     isCekClickable = true
     }
     else{
     isCekClickable = false
     }
     */
    
    var body: some View {
        if splashScreen{
            
            SplashDiceView(myDice: $myDice, theDice: $theDice, isDiceClickable: $isDiceClickable, isDotsClickable: $isDotsClickable, isCekClickable: $isCekClickable, isAnswerClickable: $isAnswerClickable, val1: $val1, intVal1: $intVal1, val2: $val2, intVal2: $intVal2, splash: $splashScreen, check1: $checkTrue, currentStage: $currentStage)
        }else{
            ZStack{
                
                BackgroundView()
                
                VStack(spacing: 0.0){
                    HeaderView(hintBtn: $hintBtn, soundBtn: $soundBtn, backHome: $backHome, currentStage: $currentStage, isDiceGlow: $isDiceGlow, isDotsGlow: $isDotsGlow, isAnswerGlow: $isAnswerGlow)
                    
                    DiceEquationView(theDice: $theDice, isDiceClickable: $isDiceClickable, hintBtn: $hintBtn, checkTrue: $checkTrue, checkTrue2: $checkTrue2, splashScreen: $splashScreen, val1: $val1, val2: $val2, result: $result, hintInformation: $hintInformation, currentStage: $currentStage, isAnswerClickable: $isAnswerClickable, isDiceGlow: $isDiceGlow, isDotsGlow: $isDotsGlow, isAnswerGlow: $isAnswerGlow)
                    
                    DotsView(dots: $dots, val1: $val1, val2: $val2, checkTrue: $checkTrue, checkTrue2: $checkTrue2, dotsCount: $dotsCount, hintInformation: $hintInformation, hintBtn: $hintBtn, intVal1: $intVal1, intVal2: $intVal2, checkFalse: $checkFalse, finalCount: $finalCount, dotsCountLap1: $dotsCountLap1, result: $result, checkCorrect: $checkCorrect, currentStage: $currentStage, isDiceClickable: $isDiceClickable, isDotsClickable: $isDotsClickable, isCekClickable: $isCekClickable, isAnswerClickable: $isAnswerClickable, isDiceGlow: $isDiceGlow, isDotsGlow: $isDotsGlow, isAnswerGlow: $isAnswerGlow)
                    
                }
                
                
                if ((checkTrue != true || finalCount != true) && (checkFalse == true)){
                    WrongAnswerView(checkFalse: $checkFalse)
                }
                
                if ((checkTrue == true || finalCount == true) && checkCorrect == true) {
                    CorrectAnswerView(finalCount: $finalCount, backHome: $backHome, checkCorrect: $checkCorrect)
                }
                
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
        
    }
    
    func addDots(at index: (row: Int, cols: Int)){
        dots[index.row].append(contentsOf: [index.cols])
    }
    
}

struct SplashDiceView: View{
    @Binding var myDice: Int
    @Binding var theDice: Int
    @Binding var isDiceClickable: Bool
    @Binding var isDotsClickable: Bool
    @Binding var isCekClickable: Bool
    @Binding var isAnswerClickable: Bool
    
    @Binding var val1: String
    @Binding var intVal1: Int
    @Binding var val2: String
    @Binding var intVal2: Int
    @Binding var splash: Bool
    @Binding var check1: Bool
    
    @Binding var currentStage: Int
    
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
            Image("Big Dice \(myDice)")
        }
        .onReceive(timer){ _ in
            DispatchQueue.main.async {
                withAnimation {
                    myDice = Int.random(in: 1...6)
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    
                    if val1 == "?"{
                        self.val1 = "\(myDice)"
                        self.intVal1 = myDice
                        theDice = myDice
                    }
                    else{
                        self.val2 = "\(myDice)"
                        self.intVal2 = myDice
                        theDice = myDice
                    }
                    
                    currentStage += 1
                    //setting the next stage
                    isDiceClickable = false
                    isDotsClickable = true
                    isCekClickable = true
                    isAnswerClickable = false
                    
                    self.splash = false
                }
            }
        }
    }
}

struct HintView: View{
    @Binding var hintBtn: Bool
    @Binding var currentStage: Int
    @Binding var isDiceGlow: Bool
    @Binding var isDotsGlow: Bool
    @Binding var isAnswerGlow: Bool
    
    let hintMessages: [String] = ["Tekan dadu untuk memulai",
                                  "Tekan bola-bola di bawah dadu sejumlah angka yang tertera lalu tekan tombol \"Cek\"",
                                  "Tekan dadu lagi untuk melanjutkan",
                                  "Tekan bola-bola di bawah dadu sejumlah angka yang tertera lalu tekan tombol \"Cek\"",
                                  "Masukan jawaban penjumlahan pada kotak"]
    
    var body: some View{
        if hintBtn{
            Text(hintMessages[currentStage])
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .frame(width: 400, height: 40)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .background(Color("SecondColor"))
                .cornerRadius(8)
                .offset(y: 10)
                .onAppear {
                    if currentStage == 0 || currentStage == 2{
                        isDiceGlow = true
                    }
                    else if currentStage == 1 || currentStage == 3{
                        isDotsGlow = true
                    }
                    else if currentStage == 4{
                        isAnswerGlow = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        hintBtn = false
                        isDiceGlow = false
                        isDotsGlow = false
                        isAnswerGlow = false
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

struct HeaderView: View {
    @Binding var hintBtn: Bool
    @Binding var soundBtn: Bool
    @Binding var backHome: Bool
    @Binding var currentStage: Int
    @Binding var isDiceGlow: Bool
    @Binding var isDotsGlow: Bool
    @Binding var isAnswerGlow: Bool
    
    var body: some View {
        HStack{
            Spacer()
            Spacer()
            Spacer()
            HintView(hintBtn: $hintBtn, currentStage: $currentStage, isDiceGlow: $isDiceGlow, isDotsGlow: $isDotsGlow, isAnswerGlow: $isAnswerGlow)
            
            Spacer()
            
            Image("Hint-1")
                .onTapGesture {
                    self.hintBtn = true
                }
            Image((soundBtn) ? "Sound Off-1" : "Sound On-1")
                .onTapGesture {
                    soundBtn.toggle()
                    
                    if soundBtn{
                        SoundManager.instance.PlaySound()
                    }else{
                        SoundManager.instance.StopSound()
                    }
                }
            
            Button(action: {
                self.backHome.toggle()
            }, label: {
                Image("Home-1")
            })
            .sheet(isPresented: $backHome){
                HomeView()
                    .transition(.move(edge: .leading))
            }
        }
        .padding(.bottom, 15.0)
    }
}

struct DiceEquationView: View {
    @Binding var theDice: Int
    @Binding var isDiceClickable: Bool
    @Binding var hintBtn: Bool
    @Binding var checkTrue: Bool
    @Binding var checkTrue2: Bool
    @Binding var splashScreen: Bool
    @Binding var val1: String
    @Binding var val2: String
    @Binding var result: Int?
    @Binding var hintInformation: String
    @Binding var currentStage: Int
    @Binding var isAnswerClickable: Bool
    @Binding var isDiceGlow: Bool
    @Binding var isDotsGlow: Bool
    @Binding var isAnswerGlow: Bool
    
    var body: some View {
        HStack(spacing: 20){
            Image("Dice \(theDice)")
                .scaledToFill()
                .onTapGesture {
                    if isDiceClickable{
                        self.hintBtn = false
                        self.splashScreen = true
                    }
                    else{
                        self.hintBtn = true
                    }
                }
                .border(isDiceGlow ? Color.green : Color.clear, width: isDiceGlow ? 5 : 0)
                .cornerRadius(10)
                .animation(.easeInOut(duration: 3), value: isDiceGlow)
            
            Text(val1)
                .font(.system(size: 140, weight: .semibold, design: .rounded))
                .foregroundColor(Color(val1=="?" ? "SecondColor": "Purple"))
                .shadow(radius: 2, x: 2, y: 2)
                .scaledToFill()
            Image("Tambah")
            Text(val2)
                .font(.system(size: 140, weight: .semibold, design: .rounded))
                .foregroundColor(Color(val2=="?" ? "SecondColor": "Green"))
                .shadow(radius: 2, x: 2, y: 2)
                .scaledToFill()
            Image("Sama Dengan")
            
            TextField("?", value: $result, format: .number)
                .frame(width: 151, height: 151)
                .multilineTextAlignment(TextAlignment.center)
                .font(.system(size: 120, weight: .semibold, design: .rounded))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("SecondColor"), lineWidth: 6)
                }
                .foregroundColor(Color("SecondColor"))
                .scaledToFill()
                .shadow(radius: 4, x: 2, y: 2)
                .keyboardType(.numberPad)
            
                .onTapGesture {
                    if !isAnswerClickable{
                        hintBtn = true
                    }
                }
                .padding(5)
                .border(isAnswerGlow ? Color.green : Color.clear, width: isAnswerGlow ? 5 : 0)
                .cornerRadius(10)
                .animation(.easeInOut(duration: 3), value: isAnswerGlow)
            
        }
    }
}

struct DotsView: View {
    @Binding var dots: [[Int]]
    @Binding var val1: String
    @Binding var val2: String
    @Binding var checkTrue: Bool
    @Binding var checkTrue2: Bool
    @Binding var dotsCount: [Int]
    @Binding var hintInformation: String
    @Binding var hintBtn: Bool
    @Binding var intVal1: Int
    @Binding var intVal2: Int
    @Binding var checkFalse: Bool
    @Binding var finalCount: Bool
    @Binding var dotsCountLap1 : Int
    @Binding var result: Int?
    @Binding var checkCorrect: Bool
    @Binding var currentStage: Int
    @Binding var isDiceClickable: Bool
    @Binding var isDotsClickable: Bool
    @Binding var isCekClickable: Bool
    @Binding var isAnswerClickable: Bool
    
    @Binding var isDiceGlow: Bool
    @Binding var isDotsGlow: Bool
    @Binding var isAnswerGlow: Bool
    
    var body: some View {
        
        HStack{
            
            VStack(spacing: 0.0){
                //this whole VStack is the stacked dots view
                ForEach(dots.indices, id: \.self){
                    rowIndex in
                    HStack{
                        ForEach(dots[rowIndex].indices, id: \.self){
                            columnIndex in
                            Image("Circle 1")
                                .onTapGesture {
                                    if isDotsClickable{
                                        withAnimation{
                                            if((val2 != "?") && (val1 != "?") && (checkTrue == true) && (checkTrue2 == false)){
                                                removeDots(index: (rowIndex, columnIndex))
                                                dotsCount.append(rowIndex)
                                            }
                                            else if ((val1 != "?" && checkTrue == false) || (val2 != "?" && checkTrue == false)){
                                                removeDots(index: (rowIndex, columnIndex))
                                                dotsCount.append(rowIndex)
                                            }
                                        }
                                    }
                                    else{
                                        hintBtn = true
                                    }
                                }
                        }
                        
                    }
                    
                }
                
            }
            .padding(10)
            .border(isDotsGlow ? Color.green : Color.clear, width: isDotsGlow ? 5 : 0)
            .cornerRadius(10)
            .animation(.easeInOut(duration: 3), value: isDotsGlow)
            .padding(.leading, 12)
            
            Spacer()
            
            VStack{
                ZStack{
                    //this whole ZStack is the dots bar view
                    RoundedRectangle(cornerRadius: 17)
                        .frame(width: 570, height: 50)
                        .foregroundColor(Color("SecondColor"))
                        .shadow(radius: 4, x: 2, y: 2)
                    HStack{
                        withAnimation{
                            ForEach(dotsCount.indices, id: \.self){
                                index in
                                Circle()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(index >= intVal1  && intVal2 > 0 ? Color("Green") : Color("Purple"))
                                    .shadow(radius: 2, x: 2, y:2)
                                    .padding(.horizontal, 6)
                                    .onTapGesture {
                                        if isDotsClickable{
                                            withAnimation{
                                                
                                                dots[dotsCount[index]].append(contentsOf: [dots.count+1])
                                                dotsCount.remove(at: index)
                                            }
                                        }
                                        else{
                                            hintBtn = true
                                        }
                                    }
                                
                            }
                        }
                    }
                }
                
                //this is the cek button view
                Button(action: {
                    if isCekClickable{
                        if val1 != "?" {
                            if checkTrue == true && checkTrue2 == true{
                                //Answer text field validation
                                self.finalCount = checkResult(Int(result ?? 0), dotsCount.count )
                                
                                if finalCount == false {
                                    //wrong answer -> show wrong display
                                    self.checkFalse = true
                                }
                                else {
                                    //correct answer -> show correct display, final stage so no increment
                                    self.checkCorrect = true
                                }
                            }
                            else{
                                if checkTrue == false {
                                    //first number validation
                                    self.checkTrue = checkDots(Int(val1) ?? 0, dotsCount.count)
                                    self.dotsCountLap1 = dotsCount.count
                                    if checkTrue == false{
                                        //wrong answer -> show wrong display
                                        self.checkFalse = true
                                    }
                                    else{
                                        //correct answer -> show correct display and move to the next stage
                                        self.checkCorrect = true
                                        currentStage += 1 // should be 2
                                        
                                        isDiceClickable = true
                                        isDotsClickable = false
                                        isCekClickable = false
                                        isAnswerClickable = false
                                    }
                                }
                                else{
                                    //second number validation
                                    self.checkTrue2 =  checkDots(Int(val2) ?? 0, dotsCount.count - dotsCountLap1)
                                    
                                    if checkTrue2 == false{
                                        //wrong answer -> show wrong display
                                        self.checkFalse = true
                                    }
                                    else{
                                        //correct answer -> show correct display and move to the next stage
                                        self.checkCorrect = true
                                        
                                        currentStage += 1 // should be 4
                                        
                                        isDiceClickable = false
                                        isDotsClickable = false
                                        isCekClickable = true
                                        isAnswerClickable = true
                                    }
                                }
                                
                                
                            }
                        }
                    }
                    else{
                        hintBtn = true
                    }
                }, label: {
                    Text("Cek")
                        .font(Font.system(size: 30))
                        .bold()
                        .frame(width: 570, height: 45)
                        .background(Color("MainBlue"))
                        .foregroundColor(Color("SecondColor"))
                        .cornerRadius(10)
                })
                .alignmentGuide(.trailing) { d in d[.trailing] }
                .padding(5)
                .border(isAnswerGlow ? Color.green : Color.clear, width: isAnswerGlow ? 5 : 0)
                .cornerRadius(10)
                .animation(.easeInOut(duration: 3), value: isAnswerGlow)
                
                
            }
            .padding(5)
            .border(isDotsGlow ? Color.green : Color.clear, width: isDotsGlow ? 5 : 0)
            .cornerRadius(10)
            .animation(.easeInOut(duration: 3), value: isDotsGlow)
            .padding(.vertical, 5)
        }
    }
    
    func removeDots(index: (row: Int, cols: Int)){
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

struct WrongAnswerView: View {
    @Binding var checkFalse: Bool
    
    var body: some View {
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
}

struct CorrectAnswerView: View {
    @Binding var finalCount: Bool
    @Binding var backHome: Bool
    @Binding var checkCorrect: Bool
    
    var body: some View {
        VStack(spacing: 0.0){
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
            
            if finalCount{
                
                Button(action: {
                    self.backHome.toggle()
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 90, height: 40)
                            .foregroundColor(Color("SecondColor"))
                            .shadow(radius: 4, x: 2, y: 2)
                        Text("Selesai")
                    }
                })
                .sheet(isPresented: $backHome){
                    HomeView()
                        .transition(.move(edge: .leading))
                }
            }
        }
        
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    if !finalCount{
                        self.checkCorrect = false
                    }
                    
                }
            }
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color("PrimaryColor"))
            
            Image("Star 1")
                .offset(y:205)
            Image("Star 2")
                .offset(x:300, y: -70)
            Image("Star 3")
                .offset(x: -400, y: 75)
        }
    }
}
