# Introduction 

Project for Blip Chat iOS sdk.

# Getting Started

Blip Chat project targets iOS 12 or later and uses swift 4.2.

# Build and Test

### Change Build ###
It's possible to generate the SDK in Release or Debug build, which connect on Production and Hmg url respectively.
To change the build hold `Ctrl + Alt` and click in *Run* on **Xcode**, or alternatively, click ***Product** -> **Scheme** ->  **Edit Scheme*** on the ***Xcode*** menu bar.
On **Run** option change the **Build Configuration** for the desired option.

### Build SDK ###
To run the project and generate the .framework, that is in fact the SDK, just click in *Run* on *XCode* up bar or press `Cmd + B`.
The .framework file will be generate on a specific file depending if the build was on Debug or Release. 
To find the file just *Right click* the **BlipChat.framework** file inside the *Products* on *Xcode* and select the option *Open in Finder*.

### Test ###
1. To run the sandbox project on debug mode change the path to your local .framework on your pod file.
2. Run **update pod** command on your project folder.
3. Then run the application.   

# Publish #
### Archiving Project ###
The first thing to do is to archive the framework by clicking ***Product** -> **Archive*** on the ***Xcode*** menu bar. If the option is greyed out, make sure to select a physical iOS device and not the iOS simulator.
### Ziping .freamework ###
Now create the .zip file by running the following command in your project directory:
```
    zip -r VERSION.zip BlipChat.framework CHANGELOG.md README.md
```
Where VERSION is the version number of the pod, e.g. `0.0.1.zip`
### Upload .zip ###
After generating the .zip file move it to `BlipChat-iOS-Doc/Releases` on blip-Chat-ios git repository and push it.
### Update PodSpec ###
In the project folder, there is a file named ***BlipChat.podspec***. Update the *version* and the *source* attributes with the latest specs of the pod.
### Publish pod ###
The last thing to do is publish the .podspec on cocoapods. In the project directory run the command:
```
    pod trunk push --allow-warnings
```

Obs: Use --allow-warnings to ignore license warnings

https://eladnava.com/publish-a-universal-binary-ios-framework-in-swift-using-cocoapods/
