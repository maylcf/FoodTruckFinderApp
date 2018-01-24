import Foundation

// Callbacks
// Typealias for callbacks used in DAta Service
typealias callback = (_ success: Bool) -> ()

// Base URL
let BASE_API_URL = "https://maylcf-foodtruck-api.glitch.me/api"

// Get All Foodtrucks
let GET_ALL_FT_URL = BASE_API_URL + "/foodtruck"

// Get all reviews for a specific foodTruck
let GET_ALL_FT_REVIEWS_URL = BASE_API_URL + "/foodtruck/reviews"

// POST add new FoodTruck
let POST_ADD_NEW_FT_URL = BASE_API_URL + "/foodtruck/add"

// POST add review for a FoodTruck
let POST_ADD_NEW_REVIEW_URL = BASE_API_URL + "/foodtruck/reviews/add"

// REGISTER URL
let POST_REGISTER_ACCT = BASE_API_URL + "/account/register"
let POST_LOGIN_ACCT = BASE_API_URL + "/account/login"

// Boolean auth UserDefaults  keys
let DEFAULTS_REGISTERED = "isRegistered"
let DEFAULTS_AUTHENTICATED = "isAuthenticated"

// Auth Email
let DEFAULTS_EMAIL = "email"
let DEFAULTS_TOKEN = "authToken"


