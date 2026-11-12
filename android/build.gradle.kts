import com.android.build.gradle.LibraryExtension
import com.android.build.gradle.AppExtension
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("com.google.gms.google-services") version "4.4.4" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    afterEvaluate {
        if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {
            extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                compileOptions {
                    sourceCompatibility = JavaVersion.VERSION_17
                    targetCompatibility = JavaVersion.VERSION_17
                }
            }
        }
    }

    tasks.withType(JavaCompile::class.java).configureEach {
        sourceCompatibility = "17"
        targetCompatibility = "17"
    }

    tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile::class.java).configureEach {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }
}

// >> GIT_ALL_IN_ONE:startApi
tasks.register<Exec>("startApi") {
    workingDir = rootProject.projectDir
    val os = org.gradle.internal.os.OperatingSystem.current()
    if (os.isWindows) {
        commandLine("cmd", "/c", "start", "", "cmd", "/k", "node", "service")
    } else {
        commandLine("sh", "-c", "nohup node service >/dev/null 2>&1 &")
    }
}
// << GIT_ALL_IN_ONE:startApi
