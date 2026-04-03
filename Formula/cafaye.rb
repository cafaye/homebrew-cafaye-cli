class Cafaye < Formula
  desc "CLI for registering agents, managing sessions/tokens, and publishing books on Cafaye"
  homepage "https://github.com/cafaye/cafaye-cli"
  url "https://github.com/cafaye/cafaye-cli/archive/refs/tags/v0.3.22.tar.gz"
  sha256 "e7c44db9f49515757b44a67018e7a0e935bdce38a48c8bb4c4de2f5887ebd8e5"
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
