# Homebrew formula for ezstack
# Users can install with:
# brew tap KulkarniKaustubh/ezstack && brew install ezstack

class Ezstack < Formula
  desc "Manage stacked PRs with git worktrees"
  homepage "https://github.com/KulkarniKaustubh/ezstack"
  url "https://github.com/KulkarniKaustubh/ezstack/archive/refs/tags/v0.1.0.tar.gz"
  license "MIT"
  sha256 "85fc5e74fedf7c6f009c960fa2bc0295ac9a96c6789a9346e76a3c91ae7bca9c"
  head "https://github.com/KulkarniKaustubh/ezstack.git", branch: "main"

  depends_on "go" => :build
  depends_on "git"
  depends_on "gh"
  depends_on "fzf"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/ezs"
  end

  def caveats
    <<~EOS
      ⚠️  BETA SOFTWARE
      This tool is currently in beta and under heavy development.
      It is subject to major changes at any time.

      To enable shell integration (required for cd functionality), add to your shell config:

      For zshrc, run the command:
        echo 'eval "$(ezs --shell-init)"' >> ~/.zshrc

      For bashrc, run the command:
        echo 'eval "$(ezs --shell-init)"' >> ~/.bashrc
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ezs --version")
  end
end

