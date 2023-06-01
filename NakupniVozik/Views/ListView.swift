import SwiftUI

struct ListView: View {
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.items) { item in
                    HStack {
                        Button(action: {
                            vm.updateItem(item: item)
                        }) {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(item.isCompleted ? .green : .gray)
                        }
                        
                        Text(item.title)
                    }
                }
                .onDelete(perform: vm.deleteItem)
            }
            .navigationTitle("Nákupní seznam")
            .toolbar {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Zavřít")
                }
                .padding()
            }
            
        }
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ViewModel())
    }
}
