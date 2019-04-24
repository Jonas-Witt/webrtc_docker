FROM osrf/ros:kinetic-desktop

RUN apt-get update && apt-get install -y \
    git \
    libgtk2.0-dev \
    libgtk-3-dev \
    libasound2-dev \
    libpulse-dev \
    locales \
    rsync \
    && rm -rf /var/likb/apt/lists/*

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir /webrtc-checkout && mkdir -p /webrtc/include && mkdir -p /webrtc/lib
WORKDIR /webrtc-checkout

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH /webrtc-checkout/depot_tools:$PATH

RUN fetch --nohooks webrtc
RUN gclient sync --nohooks # --revision "$revision"

WORKDIR /webrtc-checkout/src
RUN gn gen out/Default --args='is_debug=false is_clang=false treat_warnings_as_errors=false fatal_linker_warnings=false rtc_include_tests=false use_sysroot=false symbol_level=0'
RUN ninja -C out/Default

RUN find out/Default -type f -name lib*.a -print0 | xargs -0 -L 1 cp -t /webrtc/lib
RUN rsync -avm --include='*.h' -f 'hide,! */' . /webrtc/include

COPY webrtcConfig.cmake /webrtc/
COPY hello.cc CMakeLists.txt /test/
RUN rm -rf /test/build && mkdir -p /test/build && cd /test/build && cmake ../ && make


CMD ["bash"]
