class Eventstore < Formula
  desc "functional database with complex event processing"
  homepage "http://geteventstore.com"
  url "http://download.geteventstore.com/binaries/EventStore-OSS-MacOSX-v3.9.0.tar.gz"
  sha256 "8b89af0e29a0cc92b4f04d7586426f58191896905f47369938d34a69dcc880f2"

  bottle :unneeded

  depends_on :macos => :mavericks

  def install
    prefix.install Dir["*"]

    (bin/"eventstore").write <<-EOS.undent
      #!/bin/sh
      cd "#{prefix}"
      exec "#{prefix}/run-node.sh" "$@"
    EOS

    (bin/"eventstore-testclient").write <<-EOS.undent
      #!/bin/sh
      exec "#{prefix}/testclient" "$@"
    EOS
  end

  test do
    assert_match  /#{version}/, shell_output("#{bin}/eventstore --version")
  end
end
