class Skuf < Formula
  desc "The Skuf programming language compiler"
  homepage "https://github.com/skuf-lang/skuf"
  # url and sha256 are auto-updated by .github/workflows/release.yml
  url "https://github.com/skuf-lang/homebrew-tap/releases/download/v0.0.11/skuf-v0.0.11-source.tar.gz"
  sha256 "f477982653827460d6fd916b18973f46c6126c9c6bb37ceb391be30af830eec0"
  license "MIT"

  def install
    system "make", "-C", "stage0",
           "CC=#{ENV.cc}",
           "CFLAGS=-O2 -Wall -Wextra"
    bin.install "stage0/out/skufc-stage0" => "skufc"
    bin.install "skuf-cli.sh" => "skuf"
    bin.install "skufit"
  end

  test do
    (testpath/"hello.skf").write <<~SKF
      module main

      fn main():
        print("hello from brew")
    SKF
    system bin/"skufc", "-in", testpath/"hello.skf", "-o", testpath/"hello"
    assert_equal "hello from brew\n", shell_output(testpath/"hello")
  end
end
