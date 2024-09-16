//
//  app/api/convert/CurrentLocation.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/15/24.
// Use GeoLocation to figure out what coordinates to send to the weather API
// this is what a correct API call is supposed to look like:
// http://api.openweathermap.org/geo/1.0/reverse?lat=51.5098&lon=-0.1180&limit=5&appid={API key}

// i want this API call to get the users current location and convert it to a lattitude and longitude coordinates that the API can digest
