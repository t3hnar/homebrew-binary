require "formula"

class Eventstore < Formula
  homepage "http://geteventstore.com"
  url "http://download.geteventstore.com/binaries/EventStore-OSS-Mac-v3.0.3.tar.gz"
  sha1 "1715358a202ef2dbd79b94d3d1b58f8357e8a651"

  depends_on :macos => :mavericks

  def install
    prefix.install Dir["*"]

    (bin/"eventstore").write <<-EOS.undent
      #!/bin/sh
      cd "#{prefix}"
      exec "#{prefix}/clusternode" "$@"
      EOS

    (bin/"eventstore-testclient").write <<-EOS.undent
      #!/bin/sh
      exec "#{prefix}/testclient" "$@"
      EOS
  end

  test do
    system "#{bin}/eventstore", "--version"
    system "#{bin}/eventstore --mem-db & sleep 3; pid=$!; #{bin}/eventstore-testclient --command wrfl; #{bin}/eventstore-testclient --command rdfl; kill $pid"
  end
end
