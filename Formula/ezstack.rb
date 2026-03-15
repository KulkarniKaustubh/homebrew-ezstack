# Homebrew formula for ezstack
# Users can install with:
# brew tap KulkarniKaustubh/ezstack && brew install ezstack

class Ezstack < Formula
  desc "Manage stacked PRs with git worktrees"
  homepage "https://github.com/KulkarniKaustubh/ezstack"
  url "https://github.com/KulkarniKaustubh/ezstack/archive/refs/tags/v1.0.0.tar.gz"
  license "MIT"
  sha256 "1e0b9c0c305fe804cd9d1557a36d028a1e9a06217c7a84d7896f5694c28fa716"
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

