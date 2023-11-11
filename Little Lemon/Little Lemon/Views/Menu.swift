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
    @State var startersSelected = true
    @State var mainsSelected = true
    @State var dessertsSelected = true
    @State var drinksSelected = true
    
    var body: some View {
        VStack {
            LittleLemonLogo()
            VStack {
                withAnimation() {
                    Header()
                        .frame(maxHeight: 200)
                    }
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, 0)
                    .padding(.bottom)
            }
            .background(Color.darkGreen)

            Text("ORDER FOR DELIVERY!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing:10) {
                    Toggle("Starters", isOn: $startersSelected).toggleStyle(.button).tint(.blue).padding(.leading, 10)
                    Toggle("Mains", isOn: $mainsSelected).toggleStyle(.button).tint(.blue)
                    Toggle("Drinks", isOn: $drinksSelected).toggleStyle(.button).tint(.blue)
                    Toggle("Desserts", isOn: $dessertsSelected).toggleStyle(.button).tint(.blue)
                }
                .padding(.horizontal)
            }
            
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
        }
        .onAppear{
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
                            dish.category = menuItem.category
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
        let starters = !startersSelected ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
        let mains = !mainsSelected ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
        let desserts = !dessertsSelected ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
        let drinks = !drinksSelected ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
        }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
