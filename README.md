# Live Flutter 

This repo contains code for my [tutorial](https://getstream.io/blog/live-streaming-with-mux-stream-and-flutter/) on adding live streaming video with [Mux](https://mux.com/) and [Stream Chat](https://getstream.io/chat/) to a Flutter application. 

## Building 

To run this project, you will need to obtain an API key for [Mux](https://mux.com/) and [Stream Chat](https://getstream.io/chat/). These services allows us to integrate video and chat into our application.

When building this application, you must pass the following dart define variables as arguments:

```
--dart-define=stream-api=YOUR-KEY,
--dart-define=mux-secret=YOUR-KEY,
--dart-define=mux-api=YOUR-KEY
```

## Project Structure

The project is broken up into three layers:

    - UI/Pages
    - Blocs/Cubits
    - Backend Services

All UI code can be found in the `pages` folder while networking and api code are contained to the `backend/` directory. Domain models and blocs are stored in `lib/models` and `lib/bloc` respectively. 
