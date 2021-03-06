{ stdenv, lib, fetchPypi, buildPythonPackage, isPy3k
, numpy
, werkzeug
, protobuf
, grpcio
, markdown
, futures
, absl-py
}:

# tensorflow/tensorboard is built from a downloaded wheel, because
# https://github.com/tensorflow/tensorboard/issues/719 blocks
# buildBazelPackage.

buildPythonPackage rec {
  pname = "tensorflow-tensorboard";
  version = "1.15.0";
  format = "wheel";

  src = fetchPypi ({
    pname = "tensorboard";
    inherit version;
    format = "wheel";
  } // (if isPy3k then {
    python = "py3";
    sha256 = "1g62i3nrgp8q9wfsyqqjkkfnsz7x2k018c26kdh527h1yrjjrbac";
  } else {
    python = "py2";
    sha256 = "0l3zc8j2sh7h1z4qpy8kfvclv3kzndri55p10i42q6xahs9phav1";
  }));

  propagatedBuildInputs = [
    numpy
    werkzeug
    protobuf
    markdown
    grpcio absl-py
  ] ++ lib.optional (!isPy3k) futures;

  meta = with stdenv.lib; {
    description = "TensorFlow's Visualization Toolkit";
    homepage = http://tensorflow.org;
    license = licenses.asl20;
    maintainers = with maintainers; [ abbradar ];
  };
}
