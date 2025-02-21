plugins {
    id("com.android.application") version "8.1.0"
    id("kotlin-android") version "1.9.20" // 最新バージョンに更新（プロジェクトに応じて調整）
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    compileSdk = 33

    defaultConfig {
        applicationId = "com.m1nqto.recipe_assistant"
        minSdk = 21
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
    }

    sourceSets {
        named("main") {
            java.srcDirs += "build/generated/source/buildConfig/debug"
            res.srcDirs += "build/generated/res/resValues/debug"
        }
    }
}

flutter {
    source = "../.."
}
