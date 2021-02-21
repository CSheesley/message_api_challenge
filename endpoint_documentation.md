# MESSAGES API DOC

### Overview:
**Message** objects can be created and accessed using the requests outlined below. This is a fairly simple working proof of concept API at this point, and does not include any authentication, or sanitization of data.

Since this code is not deployed, this API endpoint can only be accessed by your **local server** address. In order for the requests listed below to work, you will need to have setup the database with the provided `seed.rb` data - and you will need to have a local server running, which can be done by entering `$ rails server` from the terminal while inside the project directory.

### How To:
To try out these endpoints and make some API requests, you can you use an app like **[Postman](https://www.postman.com/downloads/)**, you can run **CURL** commands from the Terminal, or you can use the **Developer Tools** from you favorite browser, and edit requests to the endpoint that you enter into the address bar.

_Example: CURL Commands:_
```
POST
$ curl -d "body=hey did this work" http://localhost:3000/api/v1/messages\?recipient\=chad\&sender\=mike

GET
$ curl  http://localhost:3000/api/v1/messages\?recipient\=chad
```


### Response Defaults:
By default, all responses will be:
- **Sorted** in order of **newest to oldest**, based on the Message `:created_at` attribute.
- **Limited** to Messages created in the **last 30 days**, based on the Message `:created_at` attribute..
- **Limited** to a response of **100** Messages.

---

## Endpoints:
---

### Create a Message:
```
POST    /api/v1/messages
```
##### Required Parameters:
- `:recipient`
- `:sender`
- `:body`

###### Request
`POST    http://localhost:3000/api/v1/messages?recipient=jimmy&sender=john&body=mmm sandwiches`

###### Response
```
{
    "success": "Message created"
}
```

___
### Get Messages:  

#### Get ALL Messages to a specified `:recipient`
```
GET    /api/v1/messages
```
##### Required Parameters:
- `:recipient`

###### Request
`GET    http://localhost:3000/api/v1/messages?recipient=corey`

###### Response
```
{
    "messages": [
        {
            "sender": "abbey",
            "message_id": 2,
            "created_at": "02-21-2021 19:21:59 UTC",
            "body": "Sit alias voluptatum ullam."
        },
        {
            "sender": "tommy",
            "message_id": 5,
            "created_at": "02-21-2021 19:20:59 UTC",
            "body": "Dolor beatae sit quasi."
        },
        {
            "sender": "billy",
            "message_id": 4,
            "created_at": "02-21-2021 18:21:59 UTC",
            "body": "Facere minus delectus voluptatem."
        },
        {
            "sender": "abbey",
            "message_id": 3,
            "created_at": "02-14-2021 19:21:59 UTC",
            "body": "Perspiciatis neque fuga aut."
        }
    ]
}
```
>

#### Get Messages to a specified `:recipient`, from a specified `:sender`
```
GET    /api/v1/messages
```
##### Required Parameters:
- `:recipient`
- `:sender`

###### Request
`GET    http://localhost:3000/api/v1/messages?recipient=corey&sender=abbey`

###### Response
```
{
    "messages": [
        {
            "sender": "abbey",
            "message_id": 2,
            "created_at": "02-21-2021 19:21:59 UTC",
            "body": "Sit alias voluptatum ullam."
        },
        {
            "sender": "abbey",
            "message_id": 3,
            "created_at": "02-14-2021 19:21:59 UTC",
            "body": "Perspiciatis neque fuga aut."
        }
    ]
}
```

---

## Example Requests to Try:
Based on the local seed data, here are some requests to try out.

###### Messages limited to 100
`GET    http://localhost:3000/api/v1/messages?recipient=beiber`

###### Messages those in the past month
`GET    http://localhost:3000/api/v1/messages?recipient=jagger`

###### All Messages to a `:recipient`
`GET    http://localhost:3000/api/v1/messages?recipient=corey`

###### All Messages to a `:recipient` from a specific `:sender`
`GET    http://localhost:3000/api/v1/messages?recipient=guild&sender=corey`
