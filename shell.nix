{
  pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  },
}:
pkgs.mkShell {
  buildInputs = [
    (pkgs.python312.withPackages (
      ps: with ps; [
        librosa
        soundfile
        faster-whisper
        flask
        flask-cors
        websockets
        cryptography
      ]
    ))
  ];

  shellHook = ''
    export CUDA_PATH=${pkgs.cudatoolkit}
  '';
}
