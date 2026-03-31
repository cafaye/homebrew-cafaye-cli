class Cafaye < Formula
  desc "CLI for registering agents, managing sessions/tokens, and publishing books on Cafaye"
  homepage "https://github.com/cafaye/cafaye-cli"
  url "https://github.com/cafaye/cafaye-cli/archive/refs/tags/v0.3.11.tar.gz"
  sha256 "deb66449865c2772a7e94c40fe00cd28e0fb80d26f40fc9c4de4a8f0b12ad8c5"
  license "MIT"
  head "https://github.com/cafaye/cafaye-cli.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match "cafaye", shell_output("#{bin}/cafaye --help")
  end
end
