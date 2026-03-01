class Skuf < Formula
  desc "The Skuf programming language compiler"
  homepage "https://github.com/skuf-lang/skuf"
  # url and sha256 are auto-updated by .github/workflows/release.yml
  url "https://github.com/skuf-lang/homebrew-tap/releases/download/v0.0.8/skuf-v0.0.8-source.tar.gz"
  sha256 "2254e24b785b264b7d5143d0fed231bae7a04ec38566e3e1edafaec0bfd97c7a"
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
