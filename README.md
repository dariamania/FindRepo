# Github Repository Finder

iOS App that searches repositories by name using GitHub API and OAuth

## Content
- [Screenshots](#screenshots)
- [App Features](#app-features)
- [Technologies](#technologies)
- [Tools](#tools)
- [Building and Running](#building-and-running)
- [References](#references)
- [License](#license)

## Screenshots

<pre>
<img alt="findrepo1" src="https://github.com/dariamania/FindRepo/blob/main/screenshots/findrepo1.png?raw=true" width="250">&nbsp; <img alt="findrepo2" src="https://github.com/dariamania/FindRepo/blob/main/screenshots/findrepo2.png?raw=true" width="250">&nbsp; <img alt="findrepo3" src="https://github.com/dariamania/FindRepo/blob/main/screenshots/findrepo3.png?raw=true" width="250">&nbsp; <img alt="findrepo4" src="https://github.com/dariamania/FindRepo/blob/main/screenshots/findrepo4.png?raw=true" width="250">&nbsp;
</pre>

## App Features
- [x] Basic, Personal Access Token and OAuth2 authentication
- [x] Search repositories by name
- [x] Search results are available only after authorization. Authorization through a GitHub account
- [x] Repositories are sorted by the number of stars
- [x] The search result contains 30 elements (used 2 parallel streams: the first 15 elements of the result from 1 stream and the next 15 elements from 2 stream)
- [x] Pagination is made for loading the following results (endless scrolling)
- [x] When clicking on the name, a browser opens with the information about the repository
- [x] Added a tab with the history of repository views. The history contains the last 20 viewed items, works offline, cleans up on Sign Out

## Technologies
- [x] Swift 5.6
- [x] SwiftUI
- [x] MVVM
- [x] Combine
- [x] Github API ([GitHub REST API](https://docs.github.com/en/rest))

## Tools
- [x] [Disk](https://github.com/saoudrizwan/Disk) - Framework for iOS to easily persist structs, images, and data

## Building and Running

You'll need a few things to get started.
Register your own GitHub App [here](https://github.com/settings/apps) ([GitHub Apps](https://docs.github.com/en/rest/apps/apps))
Use your Client ID and Client Secret to replace empty String values in NetworkRequest.swift file

## References

* [Implementing OAuth with ASWebAuthenticationSession](https://www.raywenderlich.com/19364429-implementing-oauth-with-aswebauthenticationsession)

## License
MIT License
