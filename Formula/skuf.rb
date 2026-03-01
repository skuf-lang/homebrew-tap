class Skuf < Formula
  desc "The Skuf programming language compiler"
  homepage "https://github.com/skuf-lang/skuf"
  # url and sha256 are auto-updated by .github/workflows/release.yml
  url "https://github.com/skuf-lang/skuf/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"

  def install
    system "make", "-C", "stage0",
           "CC=#{ENV.cc}",
           "CFLAGS=-O2 -Wall -Wextra"
    bin.install "stage0/out/skufc-stage0" => "skufc"
    bin.install "skuf-cli.sh" => "skuf"
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
