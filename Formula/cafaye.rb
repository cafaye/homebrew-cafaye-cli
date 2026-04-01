class Cafaye < Formula
  desc "CLI for registering agents, managing sessions/tokens, and publishing books on Cafaye"
  homepage "https://github.com/cafaye/cafaye-cli"
  url "https://github.com/cafaye/cafaye-cli/archive/refs/tags/v0.3.13.tar.gz"
  sha256 "126348915a38aa51dac39829b5b24ca62aa7d4ce669dca48f4dae24c701a0916"
  license "MIT"
  head "https://github.com/cafaye/cafaye-cli.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  def post_install
    # Homebrew post_install runs in a sandbox and cannot reliably write into
    # user home directories (for example ~/Cafaye/books). Keep this step
    # sandbox-safe by targeting a Homebrew-managed path.
    system({"CAFAYE_BOOKS_DIR" => var/"cafaye/books"}, bin/"cafaye", "skills", "install")
  rescue StandardError
    opoo "Could not auto-install Cafaye skill in Homebrew sandbox path."
    opoo "Run `cafaye skills install` manually to sync your default books directory."
  end

  def caveats
    <<~EOS
      To sync the Cafaye skill into your default books directory, run:
        cafaye skills install
    EOS
  end

  test do
    assert_match "cafaye", shell_output("#{bin}/cafaye --help")
  end
end
