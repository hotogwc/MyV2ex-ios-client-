HMSegmentedControl
===

[![Pod Version](http://img.shields.io/cocoapods/v/HMSegmentedControl.svg?style=flat)](http://cocoadocs.org/docsets/HMSegmentedControl)
[![Pod Platform](http://img.shields.io/cocoapods/p/HMSegmentedControl.svg?style=flat)](http://cocoadocs.org/docsets/HMSegmentedControl)
[![Pod License](http://img.shields.io/cocoapods/l/HMSegmentedControl.svg?style=flat)](http://opensource.org/licenses/MIT)

A drop-in replacement for UISegmentedControl mimicking the style of the segmented control used in Google Currents and various other Google products.

# Features
- Supports both text and images
- Support horizontal scrolling
- Supports advanced title styling with text attributes for font, color, kerning, shadow, etc.
- Supports selection indicator both on top and bottom
- Supports blocks
- Works with ARC and iOS >= 7

# Installation

### CocoaPods
The easiest way of installing HMSegmentedControl is via [CocoaPods](http://cocoapods.org/). 

```
pod 'HMSegmentedControl'
```

### Old-fashioned way

- Add `HMSegmentedControl.h` and `HMSegmentedControl.m` to your project.
- Add `QuartzCore.framework` to your linked frameworks.
- `#import "HMSegmentedControl.h"` where you want to add the control.

# Usage

The code below will create a segmented control with the default looks:

```  objective-c
HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"One", @"Two", @"Three"]];
segmentedControl.frame = CGRectMake(10, 10, 300, 60);
[segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:segmentedControl];
```

Included is a demo project showing how to fully customise the control.

![HMSegmentedControl](https://raw.github.com/HeshamMegid/HMSegmentedControl/master/Screenshot.png)

# Change log
* v1.5
	* Adds advanced styling support for default and selected state with ability to customize kerning, shadow, stroke color and width, ligature, baseline offset, paragraph style, etc.
	* A few of the control style attributes can now be customized using `UIAppearance`.
	* Adds ability to specify a border type, color and width.
	* Drops support for older iOS versions. Now works with iOS 7 and above.
	* Lots of bug fixes.	 
* v1.4
	* Lots of bug fixes
	* Add AutoLayout support
	* Adds HMSegmentedControlSelectionStyleArrow
	* Adds support for non-animated selections.
	* Adds support for custom box layer opacity.
	* Add support for multi-line labels on iOS 7+
	* Updated documentation in header file
* v1.3.0
	* Introducing horizontal scrolling via `scrollEnabled` property. Check example project
	* Adds XIB/Storyboard support
	* Fixes deprecations when building with iOS 7 SDK
	* Updates example project to support iOS 7
	* Code refactoring and cleanup
* v1.2.0
	* Added new selection indicator style: HMSelectionIndicatorBox
	* Added ability to set text colour for selected segment (thanks to [@jmkr](https://github.com/jmkr))
	* Segment titles are now added in a separate CATextLayer, and images are drawn in a separate CALayer
	* Calls to index change block/selector now happen before the animation starts
	* Lots of code refactoring and clean up
* v1.1.0 (merged pull request from [@jacksonpan](https://github.com/jacksonpan))
  * Added image support
  * Support for changing selection indicator position
* v1.0.0
	* Initial release
  
# Apps using HMSegmentedControl

If you are using HMSegmentedControl in your app or know of an app that uses it, please add it to [this list](https://github.com/HeshamMegid/HMSegmentedControl/wiki/Apps-using-HMSegmentedControl).
  

# License

HMSegmentedControl is licensed under the terms of the MIT License. Please see the [LICENSE](LICENSE.md) file for full details.

If this code was helpful, I would love to hear from you.

[@HeshamMegid](http://twitter.com/HeshamMegid)   
[http://hesh.am](http://hesh.am)
