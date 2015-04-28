#MyV2ex

[V2EX](www.v2ex.com) client IOS. Using Swift 1.2. Still on-going. Keep working on this.


## Used features

* [Kingfisher](https://github.com/onevcat/Kingfisher)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [HMSegmentedControl](https://github.com/HeshamMegid/HMSegmentedControl)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
* [MMMarkdown](https://github.com/mdiep/MMMarkdown)


## How to build
Because the app uses carthage, we need to install carthage. To install the carthage tool on your system, please download and run the Carthage.pkg file for the latest [release](https://github.com/Carthage/Carthage/releases), then follow the on-screen instructions..

1. Open Terminal app.
2. Change directory to the project folder. `cd $project_dir`
3. Use `ls` to list all the file to check whether *Cartfile* file is in the folder? 
4. If the *Cartfile* has been found, then execute `carthage update`.This will fetch dependencies into a Carthage/Checkouts folder, then build each one.
5. On your application targets’ “General” settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the Carthage/Build folder on disk. In our project, which are `Alamofire`, `Kingfisher` and `SwiftyJSON`
7. Press *Cmd + B* to build the app.
8. Press *Cmd + R* to run the app on Simulator.

##Progress

Content ViewController complete. Need more optimization.
 
Learnt more about Self-sizing cell.

User and Node ViewController are in progress








