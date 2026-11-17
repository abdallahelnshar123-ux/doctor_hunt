pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.0.1" apply false
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") version("4.3.15") apply false
    // END: FlutterFire Configuration
    id("org.jetbrains.kotlin.android") version "2.3.20" apply false
}

include(":app")

gradle.lifecycle.beforeProject {
    if (name != "app") {
        plugins.withId("com.android.library") {
            val android = extensions.findByName("android")
            if (android != null) {
                try {
                    val method = android.javaClass.methods.firstOrNull {
                        it.name in listOf("setCompileSdk", "compileSdkVersion") && it.parameterTypes.size == 1
                    }
                    method?.invoke(android, 37)
                } catch (e: Exception) {
                    // Ignore if method not found
                }
            }
        }
    }
}

