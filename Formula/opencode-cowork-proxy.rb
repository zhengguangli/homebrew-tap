class OpencodeCoworkProxy < Formula
  desc "API translation proxy for AI clients (Anthropic↔OpenAI)"
  homepage "https://github.com/zhengguangli/opencode-cowork-proxy"
  version "2.1.9"
  url "https://github.com/zhengguangli/opencode-cowork-proxy/releases/download/v2.1.9/opencode-cowork-proxy"
  sha256 "5695326f24e1aecac6bebe93169349c8116b93ca9dd8e20ace91dd622ceebbd1"

  def install
    bin.install "opencode-cowork-proxy"
  end

  def post_install
    system "brew", "services", "restart", "opencode-cowork-proxy"
  end

  service do
    run [opt_bin/"opencode-cowork-proxy"]
    environment_variables PORT: "18787", VERSION: "2.1.9"
    keep_alive true
    run_at_load true
    working_dir HOMEBREW_PREFIX
    log_path HOMEBREW_PREFIX/"var/log/opencode-cowork-proxy.log"
    error_log_path HOMEBREW_PREFIX/"var/log/opencode-cowork-proxy-error.log"
  end

  test do
    assert_predicate bin/"opencode-cowork-proxy", :executable?
  end
end
