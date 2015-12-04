# TabbedCollectionView [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![GitHub release](https://img.shields.io/badge/Release-v1.0.0-brightgreen.svg)]()

This is a combination of a `UICollectionView` and a tabbed controller. Users can use the tabs to switch among categories and the subsets are displayed in the `UICollectionView`.

## Usage

To run the example project, clone the repo, and open the 'Example/Example.xcodeproj' file.

## Requirements

This component is written using Swift and Dynamic Frameworks, so iOS 8.x is required. However you may want to manually import the source files into your project, if you need to support 7.x.

## Installation

RFCalculatorKeyboard is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
github "sprint84/TabbedCollectionView" ~> 1.0
```

###Installing Carthage

To install the `carthage` tool on your system, please download and run the `Carthage.pkg` file for the latest release, then follow the on-screen instructions.

Alternately, you can use Homebrew and install the `carthage` tool on your system simply by running brew update and `brew install carthage`.

For further details, please visit the [Carthage Github page](https://github.com/Carthage/Carthage)

##Usage

Using TabbedCollectionView is quite simple. First you need to import the Framework

```swift
import TabbedCollectionView
```
You can either create a `UIView` in a Storyboard and change its class to `TabbedCollectionView` or instantiate the view in code.

```swift
let tabbed = TabbedCollectionView()
self.view.addSubview(tabbed)
```

In order to create the tabs, you must call the method `createTabs(titles:images:)` where you can send an array of String and an array of UIImage. The two arrays must be equal size. If one array is larger than the other, the smaller size will be considered.

```swift
let titles = ["Home", "Shopping"]
let images = [UIImage(named: "home_icon")!, UIImage(named: "cart_icon")!]
tabbed.createTabs(titles, images: images)
```

The items in the collection view are populated throught the implementation of the data source methods, similarly to a normal `UICollectionView`.

```swift
func collectionView(collectionView: TabbedCollectionView, numberOfItemsInTab tab: Int) -> Int
func collectionView(collectionView: TabbedCollectionView, titleForItemAtIndexPath indexPath: NSIndexPath) -> String
func collectionView(collectionView: TabbedCollectionView, imageForItemAtIndexPath indexPath: NSIndexPath) -> UIImage
func collectionView(collectionView: TabbedCollectionView, colorForItemAtIndexPath indexPath: NSIndexPath) -> UIColor
```

The only catch here is that the method `colorForItemAtIndexPath` relies on the `tintColor` to work, so you must use your `UIImage` with the rendering mode set to `.Template`.

You must also implement the delegate protocol in order to hear back from selection actions:

```swift
func collectionView(collectionView: TabbedCollectionView, didSelectItemAtIndex index: Int, forTab tab: Int)
```

### Customization

TODO

## Author

Reefactor, Inc., reefactor@gmail.com

## License

TabbedCollectionView is available under the MIT license. See the LICENSE file for more info.
