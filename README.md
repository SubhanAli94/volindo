# Volindo - Imgur Gallery App

## Overview

Volindo is an iOS application that provides a rich and engaging way to explore content from Imgur. It's designed to deliver a smooth, visually appealing experience, focusing on presenting a variety of media, including images and videos, in an intuitive social feed.

This app is built using SwiftUI, employing a Clean Architecture with MVVM to ensure a maintainable and testable codebase. It leverages Alamofire for network requests, Swinject for dependency injection, and Kingfisher for efficient image loading and caching.

## Demo

* **Youtube Link** https://www.youtube.com/shorts/jq63o9oQ7fM
<a href="https://www.youtube.com/shorts/jq63o9oQ7fM" target="_blank">
  <img src="https://github.com/SubhanAli94/volindo/blob/main/volindoSC.jpeg" alt="Video Demo" width="300" height="700" border="0" />
</a>

## Features

* **Instagram-like Stories:** A stories section at the top of the app displays a curated selection of content, similar to Instagram Stories. Story content (image URLs) is loaded from a local JSON file.
* **Random Imgur Gallery:** Displays a feed of random images and videos from Imgur's API.
* **Mixed Media Posts:** Each post can showcase:
    * A single image
    * A single video
    * Both a video and an image within a tabbed view
* **Post Metadata:** For each post, the app displays:
    * Username (App shows "Anonymous" if this field data is empty.)
    * Caption
    * Number of favorites
    * Number of comments
    * Number of views
* **Pagination:** The app efficiently loads content with pagination.  It fetches 60 records per page and automatically loads the next page when the user scrolls near the end of the current page (20 prefetch distance).

## Tech Stack

* **Frontend:**
    * SwiftUI:  For building the user interface
* **Networking:**
    * Alamofire:  For making HTTP requests to the Imgur API ([https://github.com/Alamofire/Alamofire](https://github.com/Alamofire/Alamofire))
* **Dependency Injection:**
    * Swinject: For managing dependencies and promoting a decoupled architecture ([https://github.com/Swinject/Swinject](https://github.com/Swinject/Swinject))
* **Image Caching:**
    * Kingfisher: For efficiently loading and caching images from URLs ([https://github.com/onevcat/Kingfisher](https://github.com/onevcat/Kingfisher))
* **Architecture:**
    * Clean Architecture:  The app is structured with a clear separation of concerns into data, domain, and presentation layers.
    * MVVM (Model-View-ViewModel):  The presentation layer uses the MVVM pattern, with data managed through ViewModels.

## License

MIT License

Copyright (c) 2024 Subhan Ali

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
