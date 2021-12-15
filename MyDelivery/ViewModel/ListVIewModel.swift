import Foundation

class ListViewModel: ObservableObject {
    @Published var stores = [Store]()
    @Published var nameSort = SortBy.nameASC
    @Published var ratingSort = SortBy.ratingASC
    
    init() {
        print("SSS")
        stores = loadJsonFile()
    }
    
    private func loadJsonFile() -> [Store]{
        var dbData = [Store]()
        do {
            if let filePath  = Bundle.main.url(forResource: "DBdata", withExtension: "json") {
                
                let jsonData = try Data(contentsOf: filePath)
                let decodedData = try JSONDecoder().decode([Store].self, from: jsonData)
                print("Decoded: \(decodedData)")
                dbData = decodedData
            } else {
                return [Store]()
            }
        } catch let error {
            print("[System] Error while fetching: \(error)")
        }
        return dbData
    }
    
    func sortList(by sortType: SortBy) {
        switch sortType {
        case .nameASC:
            stores.sort {
                $0.name.lowercased() < $1.name.lowercased()
            }
        case .nameDESC:
            stores.sort {
                $0.name.lowercased() > $1.name.lowercased()
            }
        case .ratingASC:
            stores.sort {
                $0.rating < $1.rating
            }
        case .ratingDESC:
            stores.sort {
                $0.rating > $1.rating
            }
        }
    }
    
    enum SortBy: String {
        case nameASC = "Name △"
        case nameDESC = "Name ▽"
        case ratingASC = "Rating △"
        case ratingDESC = "Rating ▽"
    }
}
