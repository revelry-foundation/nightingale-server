|            | Build Status                                                                                                                                                                                   |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Production | [![Build Status](https://travis-ci.com/revelrylabs/revelry_phoenix_nightingale.svg?token=eDnMwv6sT4GHB9E2RzXt&branch=master)](https://travis-ci.com/revelrylabs/revelry_phoenix_nightingale) |

# nightingale-server

## Developer Setup

Project can be set up by running `sh ./bin/setup`. It does the steps defined below.
Note that Elixir 1.5 or greater is required in order to start it.

Once run, follow directions and start app by running `sh ./bin/server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## API Documentation


### submit_positive_location

Add a new positive location with timestamp.

```
POST /api/v1/submit_positive_location
```

#### Example Request Body

```json
{
    "app_version": "foo",
    "lat": 90.0,
    "lng": 90.0,
    "when": "2020-05-28T17:21:29Z"
}
```

#### Example Response Body

```json
{
    "data": {
        "lat": 90.0,
        "lng": 90.0,
        "when": "2020-05-28T17:21:29Z"
    },
    "ok": true
}
```

### find_proximate_positives

Find postive reports near the queried location and time.

```
GET /api/v1/find_proximate_positives
```

#### Query Parameters

| name | type | example |
| - | - | - |
| lat | float | `90.0` |
| lng | float | `90.0` |
| when | iso8601 | `2020-05-28T17:21:29Z` |

#### Example URL

http://nightingale-server.nightingale.revelry.org/api/v1/find_proximate_positives?lat=90.0&lng=90.0&when=2020-05-28T17:21:29.118Z

#### Example Response Body

```json
{
    "ok": true,
    "positives": [
        {
            "lat": 90.00000001,
            "lng": 90.00000002,
            "when": "2020-05-28T17:29:32Z"
        },
        {
            "lat": 90.00000003,
            "lng": 90.00000004,
            "when": "2020-05-28T17:32:05Z"
        }
    ]
}
```

