# libusb without udev
hunter_config(
    libusb-luxonis
    VERSION "1.0.24-cmake"
    URL "https://github.com/ibaiGorordo/libusb/archive/2332baa9118579e93b254b131a5769c7b55c96af.tar.gz"
    SHA1 "2332baa9118579e93b254b131a5769c7b55c96af"
    CMAKE_ARGS
        WITH_UDEV=OFF
)