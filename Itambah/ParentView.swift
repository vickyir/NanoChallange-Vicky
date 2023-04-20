//
//  ParentView.swift
//  Itambah
//
//  Created by Vicky Irwanto on 15/04/23.
//

import SwiftUI

struct ParentView: View {
    @State var listRules = ["1. Saat mulai bermain, orangtua mengarahkan anak untuk menekan dadu, dan tunggu hingga angka keluar.", "2. Setelah angka pertama otomatis terlihat, arahkan anak untuk menekan bola-bola sesuai dengan jumlah angka.", "3. Bola akan berpindah ke bar di sebelah kanan dan orangtua arahkan anak untuk menghitung jumlah bola.", "4. Arahkan anak untuk menge-cek apakah jumlah bola sudah sesuai dengan angka pertama, dengan menekan tombol cek.", "5. Jika sudah benar, arahkan anak untuk melanjutkan langkah selanjutnya, dengan menekan dadu lagi.", "6. Setelah muncul angka kedua, ulangi langkah selanjutnya.", "7. Arahkan anak untuk menekan bola-bola sesuai dengan jumlah angka kedua.", "8. Arahkan anak untuk menge-cek apakah jumlah yang ditekan sudah sesuai dengan angka yang muncul kedua.", "9. Jika sudah benar, lanjutkan langkah dengan menghitung keseluruhan bola.", "10. Arahkan anak untuk memasukkan jumlah angka yang sesuai dengan total jumlah bola.", "11. Tekan tombol Selesai untuk menge-cek hasil akhir penjumlahan bola.", "12. Selamat bermain dan belajar!" ]
    @State var changeView = false
    var body: some View {
        return Group{
            if changeView {
                withAnimation{
                    MainView()
                }
               
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
                   
                    VStack(alignment: .center){
                        Text("Instruksi Orang Tua")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                            
                            List(listRules, id: \.self){
                                data in
                                
                                Text(data)
                                    .listRowBackground(Color.clear)
                                    .font(.system(size: 18, weight: .light, design: .rounded))
                                    .foregroundColor(Color.black)
                            }
                            .padding(3)
                            .listStyle(.plain)
                        }
                        
                    
                        Button(action: {
                            self.changeView.toggle()
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 150, height: 35)
                                    .foregroundColor(Color("ThirdColor"))
                                    .shadow(radius: 4, x: 2, y: 2)
                                Text("Mulai Permainan")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("SecondColor"))
                            }
                            
                        })
                        .padding(.top, 5)
                    }
                    .frame(width: 700)
                    .padding(.top, 20)
                    .padding(.bottom, 1)
            
                    
                }
            }
        }
        
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
