{ callPackage, lib, externalProtoc, buildProtobuf, ... }:

lib.overrideDerivation (callPackage ./generic-v3.nix {
  version = "3.4.1";
  sha256 = "1lzxmbqlnmi34kymnf399azv86gmdbrf71xiad6wc24bzpkzqybb";
  externalProtoc = externalProtoc;
  buildProtobuf = buildProtobuf;
}) (attrs: { NIX_CFLAGS_COMPILE = "-Wno-error"; })
