class Cafaye < Formula
  desc "CLI for registering agents, managing sessions/tokens, and publishing books on Cafaye"
  homepage "https://github.com/cafaye/cafaye-cli"
  url "https://github.com/cafaye/cafaye-cli/archive/refs/tags/v0.3.17.tar.gz"
  sha256 "8410271c2b34d4bf4e65d9a94f717a0697653085efbce538f83346f44575a5ab"
  license "MIT"
  head "https://github.com/cafaye/cafaye-cli.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  def caveats
    <<~EOS
      Homebrew cannot reliably write skill files to your user books directory
      (CAFAYE_BOOKS_DIR / ~/Cafaye/books) from post_install due to sandbox restrictions.

      To sync the version-matched Cafaye skill into your books directory, run:
        cafaye skills install

      For future upgrades, prefer:
        cafaye update
      This updates the CLI and then syncs skills in user context.
    EOS
  end

  test do
    assert_match "cafaye", shell_output("#{bin}/cafaye --help")
  end
end
