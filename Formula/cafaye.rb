class Cafaye < Formula
  desc "CLI for registering agents, managing sessions/tokens, and publishing books on Cafaye"
  homepage "https://github.com/cafaye/cafaye-cli"
  url "https://github.com/cafaye/cafaye-cli/archive/refs/tags/v0.3.6.tar.gz"
  sha256 "052327bb76c3be2bb067d3b34a52408ccbe72db52f676ec63d1b893508dc63a8"
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
