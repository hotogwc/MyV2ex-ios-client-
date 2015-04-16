<p align="center" >
  <img src="https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png" alt="Kingfisher" title="Kingfisher">
</p>

Kingfisher is a lightweight and pure Swift implemented library for downloading and cacheing image from the web. This project is heavily inspired by the popular [SDWebImage](https://github.com/rs/SDWebImage). And it provides you a chance to use pure Swift alternation in your next app.

## Features

* Everything in Kingfisher goes asynchronously, not only downloading, but also caching. That means you can never worry about blocking your UI thread.
* Multiple-layer cache. Downloaded image will be cached in both memory and disk. So there is no need to download it again and this could boost your app dramatically.
* Cache management. You can set the max duration or size the cache could take. And the cache will also be cleaned automatically to prevent taking too much resource.
* Modern framework. Kingfisher uses `NSURLSession` and the latest technology of GCD, which makes it a strong and swift framework. It also provides you easy APIs to use.
* Cancellable processing task. You can cancel the downloading or retriving image process if it is not needed anymore.
* Independent components. You can use the downloader or caching system separately. Or even create your own cache based on Kingfisher's code.
* Options to decompress the image in background before render it, which could improve the UI performance.
* A category over `UIImageView` for setting image from an url directly.

## Requirements

* iOS 8.0+
* Xcode 6.3

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Kingfisher into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'Kingfisher', '~> 1.0'
```

Then, run the following command:

```bash
$ pod install
```

You should open the `{Project}.xcworkspace` instead of the `{Project}.xcodeproj` after you installed anything from CocoaPods.

For more information about how to use CocoaPods, I suggest [this tutorial](http://www.raywenderlich.com/64546/introduction-to-cocoapods-2).

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Cocoa application. To install the carthage tool, you can use [Homebrew](http://brew.sh).

```bash
$ brew update
$ brew install carthage
```

To integrate Kingfisher into your Xcode project using CocoaPods, specify it in your `Cartfile`:

```ogdl
github "onevcat/Kingfisher" >= 1.0
```

Then, run the following command to build Kingfisher framework:

```bash
$ carthage update

```

At last, you need to set up your Xcode project manually to add Kingfisher framework.

On your application targets’ “General” settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the Carthage/Build folder on disk.

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following contents:

```
/usr/local/bin/carthage copy-frameworks
```

and add the paths to the frameworks you want to use under “Input Files”:

```
$(SRCROOT)/Carthage/Build/iOS/Kingfisher.framework
```

For more information about how to use Carthage, pleasee see its [project page](https://github.com/Carthage/Carthage).

### Manually

It is not recommended to install the framework manually, but if you prefer not to use either of the aforementioned dependency managers, you can integrate Kingfisher into your project manually. A regular way to use Kingfisher in your project would be using Embedded Framework.

- Add Kingfisher as a [submodule](http://git-scm.com/docs/git-submodule). In your favorite terminal, `cd` into your top-level project directory, and entering the following command:

```bash
$ git submodule add https://github.com/onevcat/Kingfisher.git
```

- Open the `Kingfisher` folder, and drag `Kingfisher.xcodeproj` into the file navigator of your app project, under your app project.
- In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "Build Phases" panel.
- Expand the "Target Dependencies" group, and add `Kingfisher.framework`.
- Click on the `+` button at the top left of tdemohe panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `Kingfisher.framework`.

## Usage

You can find the full API documentation at [CocoaDocs](http://cocoadocs.org/docsets/Kingfisher/).

### UIImageView category

Use Kingfisher in your project is as easy as pie. You can use the `UIImageView` category and trust Kingfisher to manage downloading and cache images.

#### Basic

In your source files, add the following code:

```swift
import Kingfisher

imageView.kf_setImageWithURL(NSURL(string: "http://your_image_url.png")!)
```

Most cases, Kingfisher is used in a reusable cell. Since the downloading process is asynchronous, the earlier image will be remained during the downloading of newer one. The placeholder version of this API could help:

```swift
imageView.kf_setImageWithURL(NSURL(string: "http://your_image_url.png")!, placeHolderImage: nil)
```

#### Options

Kingfisher will search in cache (both memory and disk) first with the url, if no image found, it will try to download and store the image in the cache. You can change this behavior by passing an option, to let it ignore the cache.

```swift
imageView.kf_setImageWithURL(NSURL(string: "your_image_url")!, 
                         placeHolderImage: nil, 
                                  options: KingfisherOptions.ForceRefresh)
```

There are also other options to control the cache level, downloading priority and etc. See [documentation](http://cocoadocs.org/docsets/Kingfisher/0.0.2/Structs/KingfisherOptions.html) for more.

#### Callbacks

You can get a chance during Kingfisher downloads images and when the process done:

```swift
imageView.kf_setImageWithURL(NSURL(string: "your_image_url")!,
                         placeHolderImage: nil,
                                  options: KingfisherOptions.None,
                            progressBlock: { (receivedSize, totalSize) -> () in
                                println("Download Progress: \(receivedSize)/\(totalSize)")
                            },
                        completionHandler: { (image, error, imageURL) -> () in
                            println("Downloaded and set!")
                        }
)
```

#### Cancel Task

All `kf_setImageWithURL` methods return a `RetrieveImageTask` object. You can `cancel` the task if the images are not needed.

```swift
let task = imageView.kf_setImageWithURL(NSURL(string: "http://your_image_url.png")!)
task.cancel()

// The image retrieving will stop.
```

### Downloader & Cache system

Kingfisher will use the default downloader and cache if you do not specify them yourself. You can access them by using `KingfisherManager.sharedManager.downloader` and `KingfisherManager.sharedManager.cache`. You can adjust some parameters to meet your demands:

```swift
let downloader = KingfisherManager.sharedManager.downloader
downloader.downloadTimeout = 5 // Download process will timeout after 5 seconds. Default is 15.

let cache = KingfisherManager.sharedManager.cache

// Set max disk cache to 50 mb. Default is no limit.
cache.maxDiskCacheSize = 50 * 1024 * 1024

// Set max disk cache to duration to 3 days, Default is 1 week.
cache.maxCachePeriodInSecond = 60 * 60 * 24 * 3
```

The memory cache will be purged whenever the app switched to background or receiving a memory warning. Disk cache will be cleaned when the conditions met. You can also clear these cache manually:

```swift
// Clear memory cache right away.
cache.clearMemoryCache()

// Clear disk cache. This is an async operation.
cache.clearDiskCache()

// Clean expired or size exceeded disk cache. This is an async operation.
cache.cleanExpiredDiskCache()
```

## Future of Kingfisher

I want to keep Kingfisher slim. This framework will focus on providing a simple solution of image downloading and cache. But that not means the framework will not be improved. Kingfisher is far away from perfect and necessary and useful features will be added later, to make it better.

## About the logo

The logo of Kingfisher is inspired by [Tangram (七巧板)](http://en.wikipedia.org/wiki/Tangram), a dissection puzzle consisting of seven flat shapes from China. I believe she's a kingfisher bird instead of a swift, but someone persists that she is a pigeon. I guess I should give her a name. Hi, guys, do you have any suggestion?

## Contact

Follow and contact me on [Twitter](http://twitter.com/onevcat) or [Sina Weibo](http://weibo.com/onevcat). If you find an issue, just [open a ticket](https://github.com/onevcat/Kingfisher/issues/new) on it. Pull requests are warmly welcome as well.

## License

Kingfisher is released under the MIT license. See LICENSE for details.

