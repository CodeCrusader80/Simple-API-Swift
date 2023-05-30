//
//  APIResult.swift
//  ComprendreLesAPI
//
//  Created by Mathieu @theunknowman_80 29/05/2023.


//In this new file, simply paste the data retrieved in JSON. Of course, errors will pop up everywhere, so comment out the block and identify the data you are interested in among those displayed in the file. Then, create Decodable structs with the targeted data, specifying variables if necessary to obtain a struct that will group a set of decoded data. Insert these structs into another struct, using variable names associated with the data returned in the JSON. This way, you can build data around a randomly created user

import Foundation

struct ApiResults: Decodable {
    var results: [User]
}

struct User: Decodable {
    var gender: String
    var name: Name
    var location: Location
    var email: String
    var nat: String
    var phone: String
    var cell: String
    var dob: Birth
    var picture: Picture
}

struct Name: Decodable {
    var title: String
    var first: String
    var last: String
}

struct Location: Decodable {
    var street : Street
    var city: String
    var state: String
    var country: String
}

struct Street: Decodable {
    var number : Int
    var name: String
}

struct Birth: Decodable {
    var date: String
    var age: Int
}

struct Picture: Decodable {
    var large: String
    var medium: String
    var thumbnail: String
}
