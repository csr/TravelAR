# TravelAR
Hey Shopify 👋 Thank you for checking out my app. TravelAR makes traveling and learning new languages easy by translating anything around you using your phone camera, machine learning and augmented reality.

## Screenshots
| Point and translate  | Listen and learn | Listen and learn |
| ------------- | ------------- | ------------- |
| ![](/Screenshots/appstore_1.jpg?raw=true)  | ![](/Screenshots/appstore_2.jpg?raw=true) | ![](/Screenshots/appstore_3.jpg?raw=true)  |

| Play with flashcards  | Review what you learnt | Select language from list |
| ------------- | ------------- | ------------- |
| ![](/Screenshots/onboarding_1.png?raw=true)  | ![](/Screenshots/onboarding_2.png?raw=true)  | ![](/Screenshots/onboarding_3.png?raw=true)  |

## How I built TravelAR
When people travel to a new country, it’s hard to learn to speak the local language, so we rely on gestures and facial expressions to communicate, without much success. I have always wanted to be able to point my device at an object and know the name of that object in another language, so I’ve decided to build a Swift app that does just that. 

 In the app, simply select the language you’d like to learn from the list (e.g. Portuguese) and point your iPad at an object. You'll see the results provided by the machine learning model, based on what the iPad is picturing. When you tap on the screen, the app provides a translation in your language of choice on top of the object as 3D text. You can also hear how the translation is pronounced in the local language and you can browse a list of the scanned items by tapping on the buttons at the top. To make this experience work, I have implemented several Apple technologies, such as CoreML, SceneKit, and ARKit. The app is also translated in multiple languages.

![build status](https://build.appcenter.ms/v0.1/apps/e0928fc1-253b-4e65-81cd-01e013fd6c0d/branches/master/badge)

## Building the app
To test the app, add your own Google Cloud key by creating a file `GoogleAPIKey.txt` inside the main project directory. The app will automatically parse the key inside the file to make requests to the Translation API.

## License
TravelAR is under the [MIT License](https://github.com/cesaredecal/TravelAR/blob/master/LICENSE.txt)
