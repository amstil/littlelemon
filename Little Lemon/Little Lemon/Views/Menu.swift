//
//  Menu.swift
//  Little Lemon
//
//  Created by Anastasia on 09.11.23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""

    
    var body: some View {
        VStack {
            Text("Little Lemon").foregroundColor(Color(red: 0.5191, green: 0.4383, blue: 0.00426)).font(.system(size:40)).padding(.horizontal, 10)
            Text("Chicago").foregroundColor(Color.black).font(.system(size: 20)).padding(.leading, 10).padding(.bottom, 10)
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.").padding(.leading, 10)
            TextField("Search menu", text: $searchText).textFieldStyle(RoundedBorderTextFieldStyle()).padding(10)
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List {
                    if dishes.count != 0 {
                        ForEach(dishes, id: \.self) { dish in
                            HStack {
                                VStack(alignment: .leading){
                                    Text(dish.title!).font(Font.headline.weight(.bold))
                                    Spacer()
                                    Text("$" + dish.price!)
                                }
                                Spacer()
                                AsyncImage(url: URL(string: dish.image!)) {image in image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 100)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear{
            getMenuData()
        }
    }
    
    func getMenuData() {
            PersistenceController.shared.clear()
            
            let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
                if let data {
                    let jsonDecoder = JSONDecoder()
                    let menuList = try? jsonDecoder.decode(MenuList.self, from: data)
                    if let menuList {
                        for menuItem in menuList.menu {
                            let dish = Dish(context: viewContext)
                            dish.title = menuItem.title
                            dish.price = menuItem.price
                            dish.image = menuItem.image
                        }
                        try? viewContext.save()
                    }
                }
            }
            task.resume()
        }
    
    func buildSortDescriptors () -> [NSSortDescriptor] {
        return [NSSortDescriptor (
            key: "title",
            ascending: true,
            selector: #selector(NSString.localizedStandardCompare)
        )]
    }
    
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search])
        return compoundPredicate
        }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
