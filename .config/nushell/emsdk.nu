def emsdk_env [] {
  load-env {
    PATH: ($env.PATH | append '/Users/tranlynhathao/emsdk')
    PATH: ($env.PATH | append '/Users/tranlynhathao/emsdk/node/20.18.0_64bit/bin')
    PATH: ($env.PATH | append '/Users/tranlynhathao/emsdk/upstream/emscripten')
    EMSDK: "/Users/tranlynhathao/emsdk"
    EM_CONFIG: "/Users/tranlynhathao/emsdk/.emscripten"
    EMSCRIPTEN: "/Users/tranlynhathao/emsdk/upstream/emscripten"
  }
}
