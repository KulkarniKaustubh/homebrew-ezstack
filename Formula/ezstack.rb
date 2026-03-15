# Homebrew formula for ezstack
# Users can install with:
# brew tap KulkarniKaustubh/ezstack && brew install ezstack

class Ezstack < Formula
  desc "Manage stacked PRs with git worktrees"
  homepage "https://github.com/KulkarniKaustubh/ezstack"
  url "https://github.com/KulkarniKaustubh/ezstack/archive/refs/tags/v1.0.0.tar.gz"
  license "MIT"
  sha256 "8a07b18109431a5e56aa379c03c1dc3c518c081c2251da1343b724d649ba439b"
  head "https://github.com/KulkarniKaustubh/ezstack.git", branch: "main"

  depends_on "go" => :build
  depends_on "git"
  depends_on "gh"
  depends_on "fzf"

  def install
    system "go", "build", "-ldflags", "-s -w", "-o", bin/"ezs", "./cmd/ezs"
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

