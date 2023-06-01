import SwiftUI

struct InsertView: View {
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Nový seznam...")
                    .font(.title)
                    .fontWeight(.black)
                itemButton
                    .padding()
            }
            .padding()
        }
        .onDisappear {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var itemButton: some View {
        VStack {
                TextField("Přidat položku", text: $vm.textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
            
            HStack {
                Button(action: {
                    vm.addItem(title: vm.textFieldText)
                    vm.textFieldText = ""
                }) {
                    HStack{
                        Image(systemName: "cart.badge.plus")
                            .foregroundColor(.green)
                        Text("Přidat")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding(.vertical)
                
                Button(action: {
                    vm.saveButtonPressed()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack{
                        Image(systemName: "bag")
                            .foregroundColor(.green)
                        Text("Uložit")
                            .foregroundColor(.white)
                            .font(.headline)
                            
                    }
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                }
                .padding(.vertical)
            }
        }
    }
}

struct InsertView_Previews: PreviewProvider {
    static var previews: some View {
        InsertView()
            .environmentObject(ViewModel())
    }
}
