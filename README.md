# TravelAR: Translate anything with your camera
[![Build status](https://build.appcenter.ms/v0.1/apps/e0928fc1-253b-4e65-81cd-01e013fd6c0d/branches/master/badge)](https://appcenter.ms)

TravelAR is an iOS app that makes traveling and learning new languages easy by translating anything around you using your phone camera, machine learning, and augmented reality. 

* Written in Swift
* Powered by CoreML, ARKit, and the Google Cloud Translation API
* Auto Layout was written entirely with code (very few Storyboards/XIBs)
* Supports localization with localizable strings
* Continous Integration with AppCenter.ms (looking into transitioning to Travis CI)

![](demo.gif)

## Technical Details
At a high level, the app uses a local machine learning model (Inception V3) to perform object recognition via CoreML by analyzing the incoming camera frames. If the user taps on the plus button and an object in-view was successfully recognized, we send the object name along with the target language (the language we want to translate to) to the Google Cloud Platform API. After the API gets back to the app with the result, we create an ARKit node with the translated text and place it on the object that's been recognized. The user can tap the ARKit view to learn more about the translation and listen to the correct pronunciation with AVSpeechSynthesizer. To get started with the project, you can take a look at the `TranslateController` class which handles the app core functionality. 

## Motivation
When people travel to a new country, it’s hard to learn to speak the local language, so we rely on gestures and facial expressions to communicate, without much success. I have always wanted to be able to point my device at an object and know the name of that object in another language, so I’ve decided to build a Swift app that does just that. 

 In the app, simply select the language you’d like to learn from the list (e.g. Portuguese) and point your device at an object. You'll see the results provided by the machine learning model, based on what the iPad is picturing. When you tap on the screen, the app provides a translation in your language of choice on top of the object as 3D text. You can also hear how the translation is pronounced in the local language and you can browse a list of the scanned items by tapping on the buttons at the top. To make this experience work, I have implemented several Apple technologies, such as CoreML, SceneKit, and ARKit. The app is also translated into multiple languages.

## Building the app
To run the app, first run `carthage update` to update the dependencies. Then, place your Google Cloud Platform Translate API key in the `GoogleAPIKey.txt` file at the root level. Although this is not necessary for the app to run, you will need to include the key to make requests to the Translation API. If the API Key supplied is invalid or isn't found, the app will display an alert message to let you know.

## Future Improvements
A few interesting future technical goals would be:
* Implement a caching mechanism to reduce the number of calls made to the Google Cloud Translation API.
* Reduce CPU usage by optimizing the CoreML implementation (for example, by reducing the number of camera frames per second analyzed by the model).
* Implement offline translation. We could find the most common or most useful words translated and go from there. A good place to start would be checking out the [Oxford Dictionaries API](https://developer.oxforddictionaries.com/) for the JSON files.

Pull requests are welcome.

## Screenshots
| Point and translate  | Listen and learn | Review what you learn |
| ------------- | ------------- | ------------- |
| ![](/Screenshots/appstore_1.png?raw=true)  | ![](/Screenshots/appstore_2.png?raw=true) | ![](/Screenshots/appstore_3.png?raw=true)  |

| Welcome  | Camera permission | Language selection |
| ------------- | ------------- | ------------- |
| ![](/Screenshots/onboarding_1.png?raw=true)  | ![](/Screenshots/onboarding_2.png?raw=true)  | ![](/Screenshots/onboarding_3.png?raw=true)  |

## License
TravelAR is under the [MIT License](https://github.com/cesaredecal/TravelAR/blob/master/LICENSE.txt)
