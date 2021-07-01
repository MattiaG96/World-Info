//
//  ContentView.swift
//  GraphQLCountry
//
//  Created by Mattia Garreffa on 1/7/21.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Variables de estado
    @State var selection = 0
    @State var countryCode = ""
    @State var countryPhone = ""
    @State var countryLanguge = ""
    @State var countryCurrency = ""
    @State var countryCapital = ""
    @State var countryEmoji = ""
    
    // MARK: - Variables
    let countries = ["United States", "Italy", "Spain", "Netherlands", "Great Britain", "France", "Persia", "Ireland", "Greece", "Uganda", "China", "Japan", "New Zeland", "India", "Mexico"]
    
    var body: some View {
        
        // MARK: - Cabecera
        // Logo, texto y picker.
        VStack {
            Spacer().frame(width: .none, height: 20, alignment: .center)
            Image("LogoTrans").resizable().aspectRatio(contentMode: .fit).frame(width: 200.0, height: 150.0)
            VStack {
                Text("Choose a country")
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(.orange)
                Picker("Country", selection: $selection) {
                    ForEach(0..<countries.count) { index in
                        Text("\(self.countries[index])")
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
                .frame(width: .none, height: 100, alignment: .center)
                .labelsHidden()
                .clipped()
            }
            // MARK: - Información
            // VStack con los textos y la información recogida en con GraphQL
            Spacer().frame(width: .none, height: 20, alignment: .center)
            Divider().background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.orange/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .leading, spacing: 10.0) {
                Spacer().frame(width: .none, height: 10, alignment: .center)
                HStack {
                    Spacer().frame(width: 20, height: 1, alignment: .center)
                    Text("Country code: ")
                    Text("\(countryCode)")
                        .foregroundColor(.orange)
                        .font(.title3)
                    Spacer()
                }
                HStack {
                    Spacer().frame(width: 20, height: 1, alignment: .center)
                    Text("Phone prefix: ")
                    Text("\(countryPhone)")
                        .foregroundColor(.orange)
                        .font(.title3)
                    Spacer()
                }
                HStack {
                    Spacer().frame(width: 20, height: 1, alignment: .center)
                    Text("Language: ")
                    Text("\(countryLanguge)")
                        .foregroundColor(.orange)
                        .font(.title3)
                    Spacer()
                }
                HStack {
                    Spacer().frame(width: 20, height: 1, alignment: .center)
                    Text("Currency: ")
                    Text("\(countryCurrency)")
                        .foregroundColor(.orange)
                        .font(.title3)
                    Spacer()
                }
                HStack {
                    Spacer().frame(width: 20, height: 1, alignment: .center)
                    Text("Capital: ")
                    Text("\(countryCapital)")
                        .foregroundColor(.orange)
                        .font(.title3)
                    Spacer()
                }
                HStack {
                    Spacer().frame(width: 20, height: 1, alignment: .center)
                    Text("\(countryEmoji)").font(.system(size: 100)).frame(maxWidth: .infinity).minimumScaleFactor(0.5)
                    Spacer().frame(width: 20, height: 1, alignment: .center)
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            // MARK: - Botón
            // Botón Show Info
            HStack {
                Spacer().frame(width: 40, height: 1, alignment: .center)
                
                Button(action: {
                    showInfo()
                }, label: {
                    Text("SHOW INFO")
                        .font(.title3)
                        .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
                })
                .frame(maxWidth: .infinity)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.orange/*@END_MENU_TOKEN@*/)
                .cornerRadius(5.0)
                .foregroundColor(.white)
                
                Spacer().frame(width: 40, height: 1, alignment: .center)
            }
            Spacer().frame(width: .none, height: 20, alignment: .center)
        }
    }
    
    // MARK: - Funciones
    
    /**
     Función que recoge la información del picker y llama a getInfo() con esa información.
     */
    func showInfo() {
        switch selection {
        case 0:
            countryCode = "US"
            getInfo(cc: countryCode)
        case 1:
            countryCode = "IT"
            getInfo(cc: countryCode)
        case 2:
            countryCode = "ES"
            getInfo(cc: countryCode)
        case 3:
            countryCode = "NL"
            getInfo(cc: countryCode)
        case 4:
            countryCode = "GB"
            getInfo(cc: countryCode)
        case 5:
            countryCode = "FR"
            getInfo(cc: countryCode)
        case 6:
            countryCode = "IR"
            getInfo(cc: countryCode)
        case 7:
            countryCode = "IE"
            getInfo(cc: countryCode)
        case 8:
            countryCode = "GR"
            getInfo(cc: countryCode)
        case 9:
            countryCode = "UG"
            getInfo(cc: countryCode)
        case 10:
            countryCode = "CN"
            getInfo(cc: countryCode)
        case 11:
            countryCode = "JP"
            getInfo(cc: countryCode)
        case 12:
            countryCode = "NZ"
            getInfo(cc: countryCode)
        case 13:
            countryCode = "IN"
            getInfo(cc: countryCode)
        case 14:
            countryCode = "MX"
            getInfo(cc: countryCode)
        default:
            countryCode = "US"
            getInfo(cc: countryCode)
        }
    }
    
    /**
     Parametros:
        -   cc : String definiendo el countryCode  necesario para la query de graphQL
     Función:
        Realiza una query mediante grapQL a https://countries.trevorblades.com/ , recoge la información recibida y actualiza las variables de estado con dicha información.
     */
    func getInfo(cc: String) {
        Network.shared.apollo.fetch(query: SpecificCountryQuery(countryCode: cc)) { result in
            switch result {
            case .success(let grapQLResult):
                DispatchQueue.main.async {
                    if let language = grapQLResult.data?.country?.languages[0].name {
                        self.countryLanguge = language
                    }
                    if let currency = grapQLResult.data?.country?.currency {
                        self.countryCurrency = currency
                    }
                    if let capital = grapQLResult.data?.country?.capital {
                        self.countryCapital = capital
                    }
                    if let emoji = grapQLResult.data?.country?.emoji {
                        self.countryEmoji = emoji
                    }
                    if let phone = grapQLResult.data?.country?.phone {
                        self.countryPhone = "+\(phone)"
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
