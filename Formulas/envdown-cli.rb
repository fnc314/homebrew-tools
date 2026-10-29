class EnvdownCli < Formula
  desc "Pre-processor to inject environment variables into Markdown files"
  homepage "https://github.com/fnc314/envdown"
  version "1.0.0"
  on
  _
  macos do
    on
    _arm do
      url "https://github.com/fnc314/envdown/releases/download/v#{version}/envdown-cli-macos-arm64.tar.gz"
      sha256 "<INSERT_ARM64_MAC_SHA256_HERE>"
    end
    on
    _intel do
      url "https://github.com/fnc314/envdown/releases/download/v#{version}/envdown-cli-macos-x64.tar.gz"
      sha256 "<INSERT_INTEL_MAC_SHA256_HERE>"
    end
  end
  on
  _
  linux do
    on
    _intel do
      url "https://github.com/fnc314/envdown/releases/download/v#{version}/envdown-cli-linux-x64.tar.gz"
      sha256 "<INSERT_LINUX_SHA256_HERE>"
    end
  end
  def install
    # The toolchain names the output 'envdown-cli.kexe'.
    # We rename it during installation to drop the extension.
    bin.install "envdown-cli.kexe" => "envdown"
  end
  test do
    # Create a dummy EnvDown file to test the installation
    (testpath / "test.envdown").write <<~EOS
      Hello ${env.TEST_VAR:-World}
    EOS
    # Run the binary with an environment variable set
    output = pipe_
    output("TEST_VAR=Homebrew #{bin}/envdown test.envdown")
    assert
    _
    match "Hello Homebrew", output
  end
end
