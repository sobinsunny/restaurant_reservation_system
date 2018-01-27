# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

server 
    `https://fathomless-wave-80040.herokuapp.com/restaurants`
***Api***

* 1) Create Resturant*
   ```
   POST https://fathomless-wave-80040.herokuapp.com/restaurants
   params {
    "restaurant": 
        {
            "email":"sobin.com", 
            "name":"kairali",
            "phone_number": 8867231414 
        }
    } 
```
* 2) View Resturant *
   GET https://fathomless-wave-80040.herokuapp.com/restaurants
* Table Create
 POST https://fathomless-wave-80040.herokuapp.comtables?restaurant_email=abc@gmail.com
 params =
 {"table": 
    {
        "restaurant_email":"abc@gmail.com", 
        "number":"5",
        "number_of_seats":"5"
    }
}
*reservation create*
POST https://fathomless-wave-80040.herokuapp.com/reservations?restaurant_email=abc@gmail.com
Params
{
    "reservation": {
        "guest_email": "sobi@gmail.com",
        "guest_name": "sobin",
        "guest_party_size": 1,
        "requested_date_time": "30-1-2018 11 AM"
    }
}
GET https://fathomless-wave-80040.herokuapp.com/reservations?restaurant_email=abc@gmail.com

* Reservation Update *
https://fathomless-wave-80040.herokuapp.com/reservations/1
params
{
    "reservation": {
        "guest_party_size": 3,
        "requested_date_time": "28-1-2019 1 PM"
    }
}
