

# Cocoapods

CocoaPods is an application level dependency manager for Objective-C, Swift and any other languages that run on the Objective-C runtime, such as RubyMotion, that provides a standard format for managing external libraries.

## install


- This is the simplest

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install cocoapods

- Using gem

1. First open your terminal

2. Then update your gem file with command

sudo gem install -n /usr/local/bin cocoapods
3. Then give your project path

cd /your project path
4. Touch the podifle

touch podfile
5. Open your podfile

open -e podfile
6. It will open a podfile like a text edit. Then set your target. For example if you want to set up Google maps then your podfile should be like

use_frameworks!
target 'yourProjectName' do
    pod 'GoogleMaps'
end
7. Then install the pod

pod install




