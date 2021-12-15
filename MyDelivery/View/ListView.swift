import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel = ListViewModel()
    
    @State var inputText = ""
    @State var seletedCuisine = Food.all
    @State var isOnSale = false
    
    var body: some View {
        VStack {
            AppBarView(inputText: $inputText, seletedCuisine: $seletedCuisine, isOnSale: $isOnSale)
                .environmentObject(viewModel)
                .padding(.bottom, 5)
                .overlay(Divider()
                            .frame(width: UIScreen.main.bounds.width)
                            .background(Color.black), alignment: .bottom)
                .padding(.bottom, 5)
                
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.stores.filter({ store in
                        filterSearchText(store)
                    }).filter({ store in
                        filterCuisine(store)
                    }).filter({ store in
                        filterOnSale(store)
                    }), id: \.self) { store in
                        StoreView(store: store)
                    }
                }
            }
        }
    }
    
    private func filterSearchText(_ store: Store) -> Bool {
        if inputText == "" || store.name.localizedCaseInsensitiveContains(inputText) {
            return true
        } else {
            return false
        }
    }
    
    private func filterCuisine(_ store: Store) -> Bool {
        if seletedCuisine == .all || seletedCuisine == store.type
        {
            return true
        } else {
            return false
        }
    }
    
    private func filterOnSale(_ store: Store) -> Bool {
        if !isOnSale || store.tags.firstIndex(of: "On sale") != nil {
            return true
        } else {
            return false
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
