//
//  Apollo.swift
//  GraphQLCountry
//
//  Created by Mattia Garreffa on 1/7/21.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
}
