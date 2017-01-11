
Blip SDK for iOS
======

SDK to easily add BLiP conversations in your iOS app. For more information see [BLiP portal][1] and [BLiP documentation][2].

Installation
--------

### Prerequisites

To use the Blip SDK for iOS, you will need the following installed on your development machine:

<!-- Xcode 7 or later -->
<!-- iOS 8 or later -->

Import the Blip SDK for iOS into your project via CocoaPods:

1. If you have not installed CocoaPods, install it by running the command:

        $ gem install cocoapods
        $ pod setup

<!-- Depending on your system settings, you may have to use `sudo` for installing `cocoapods` as follows: -->

<!-- $ sudo gem install cocoapods -->
<!-- $ pod setup -->

2. Create a plain text file named `Podfile` (without any file extension) inside your project directory. Add the lines below to your file and replace `YourTarget` with your actual target name.

        # Uncomment the next line to define a global platform for your project
        # platform :ios, '9.0'

        target 'blip-sdk-webview' do
          # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
          use_frameworks!

          # Pods for blip-sdk-webview
          #pod “BlipSDK”, :path => “../../sdk/BlipSDK”
          pod "BlipSDK"

          pod 'Google-Mobile-Ads-SDK'

          target 'blip-sdk-webviewTests' do
            inherit! :search_paths
            # Pods for testing
          end

          target 'blip-sdk-webviewUITests' do
            inherit! :search_paths
            # Pods for testing
          end

        end

3. Run the following command

        $ pod install

4. Open up `*.xcworkspace` with Xcode and start using the SDK

    **Note**: Do **NOT** use `*.xcodeproj`. If you open up a project file instead of a workspace, you receive an error:

<!-- ld: library not found for -lPods-AWSCore -->
<!-- clang: error: linker command failed with exit code 1 (use -v to see invocation) -->

How to use
-------------------------

### Setting your SDK

After include sdk reference on your project you must provide a valid **BLiP owner account**.
Only with this special account is possible to use this sdk.

__To get an owner account enter in contact with BLiP team__

### After getting your owner account

1. Create a new plist file named **blip.plist** on your project


2. Set your credentials, like bellow, on **blip.plist** file

*TODO

## Quick start

###Getting Started with Swift

###Getting Started with Objective-C

### Openning a new BLiP conversation

To open a new thread is very simple. Use **BlipClient** helper class and call *openBlipThread* method


*TODO


*To find your chatbot identifier go to [BLiP Portal](https://portal.blip.ai/#/application), select your chatbot and click 'Settings' on the left bar.

## Advanced features

### Setting information about your client

Sometimes, is very important that your chatbot knows information about your customers, as name or some external identifier for example.
To do this use *setUserAccount* method on **BlipClient** helper class.

*TODO

For instance,

*TODO

License
-------

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


 [1]: https://blip.ai
 [2]: https://portal.blip.ai/#/docs/home
 [3]: http://search.maven.org/#search%7Cga%7C1%7Cg%3A%22net.take%22
 [snap]: https://oss.sonatype.org/content/repositories/snapshots/
