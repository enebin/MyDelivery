import SwiftUI

struct StoreView: View {
    let store: Store
    
    var body: some View {
        VStack {
            Image(stringURL: store.imageURL)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width-50, height: 200)
                .clipped()
            
            
            VStack {
                HStack {
                    Text(store.name)
                        .font(.title)
                        .bold()
                    Spacer()
                    Text(store.location)
                        .font(.subheadline)
                }
                .padding(.bottom, 1)
                
                HStack(spacing: 0) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(store.rating))
                        .padding(.trailing)
                    Text(store.type.rawValue)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.bottom, 1)
                
                HStack {
                    ForEach(store.tags, id: \.self) { tag in
                        Text(tag)
                            .encapulate(color: .black.opacity(0.8), foregroundColor : .white)
                    }
                    Spacer()
                }
                .padding(.bottom)
            }
            .frame(width: UIScreen.main.bounds.width-50)
        }
    }
}
