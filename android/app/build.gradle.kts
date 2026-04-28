plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ai_menu_flutter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.ai_menu_flutter"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            isMinifyEnabled = false
            isShrinkResources = false

        }

        debug {
            isMinifyEnabled = false
            isShrinkResources = false
        }

    }
}

repositories {
    flatDir {
        dirs("libs")
    }
    maven {
        url = uri("https://jfrog.anythinktech.com/artifactory/overseas_sdk")
    }
}

dependencies {

    // Thinkup SDK (Necessary)
    implementation("com.thinkup.sdk:core-tpn:6.5.10")
    implementation("com.thinkup.sdk:nativead-tpn:6.5.10")
    implementation("com.thinkup.sdk:banner-tpn:6.5.10")
    implementation("com.thinkup.sdk:interstitial-tpn:6.5.10")
    implementation("com.thinkup.sdk:rewardedvideo-tpn:6.5.10")
    implementation("com.thinkup.sdk:splash-tpn:6.5.10")

    // Androidx (Necessary)
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("androidx.browser:browser:1.4.0")

    // AdMob
    implementation("com.thinkup.sdk:adapter-tpn-admob:6.5.10")
    implementation("com.google.android.gms:play-services-ads:24.4.0")

    // Tramini
    implementation("com.thinkup.sdk:tramini-plugin-tpn:6.5.10")
}


flutter {
    source = "../.."
}
