import SwiftUI

struct FirstView: View {
    @EnvironmentObject private var vm: ViewModel
    @State private var isInsertViewActive = false
    @State private var isListViewActive = false
    @State private var cartOffsetX: CGFloat = -300 // Počáteční hodnota offsetu vozíku

    var body: some View {
        ZStack {
            //Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1))
                //.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Nákupní Vozík")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .underline()
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "cart")
                    .resizable()
                    .frame(width: 100, height: 80)
                    .fontWeight(.medium)
                    .padding()
                    .offset(x: cartOffsetX) // Použití offsetu pro animaci pohybu vozíku
                
                Divider()
                    .background(Color.black)
                    .frame(height: 1)
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    isInsertViewActive = true
                }) {
                    HStack{
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                            .font(.title2)
                        
                        Text("Vytvořit nákupní seznam")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 350)
                    .background(Color.black)
                    .cornerRadius(10)
                }
                .sheet(isPresented: $isInsertViewActive) {
                    InsertView()
                        .environmentObject(vm)
                }
                
                ButtonLoad
                Spacer()
            }
            .padding()
        }
        .onAppear {
            // Animace pohybu vozíku při zobrazení obrazovky
            withAnimation(Animation.linear(duration: 1.5).repeatForever()) {
                cartOffsetX = 300 // Konečná hodnota offsetu pro animaci pohybu vozíku
            }
        }
    }
    
    private var ButtonLoad: some View {
        Button(action: {
            isListViewActive = true
        }) {
            HStack{
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.blue)
                    .font(.title2)
                
                Text("Načíst seznam")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(width: 350)
            .background(Color.black)
            .cornerRadius(10)
        }
        .sheet(isPresented: $isListViewActive) {
            ListView()
                .environmentObject(vm)
        }
    }
}


struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
            .environmentObject(ViewModel())
    }
}
