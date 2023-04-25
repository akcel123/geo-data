//
//  GeoDataURLNames.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.03.2023.
//

import Foundation

enum GeoDataURLNames {
    static let createNewItem = "http://31.31.203.201:8565/api/v1/Geodata/create"
    static let getEventList = "http://31.31.203.201:8565/api/v1/Geodata/getGeoDataList"
    static let deleteEvent = "http://31.31.203.201:8565/api/v1/geodata"
    static let updateEvent = "http://31.31.203.201:8565/api/v1/Geodata/updateGeodata"
    
    static let registration = "http://31.31.203.201:8565/api/v1/account/register"
    static let logIn = "http://31.31.203.201:8565/api/v1/account/login"
    static let deleteUser = "http://31.31.203.201:8565/api/v1/account/deleteuser"
    static let refreshToken = "http://31.31.203.201:8565/api/v1/account/refreshToken"
    static let getUser = "http://31.31.203.201:8565/api/v1/account/GetUser/"
}


