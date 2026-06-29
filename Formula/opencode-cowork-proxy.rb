class OpencodeCoworkProxy < Formula
  desc "API translation proxy for AI clients (Anthropic↔OpenAI)"
  homepage "https://github.com/zhengguangli/opencode-cowork-proxy"
  version "2.2.2"
  url "https://github.com/zhengguangli/opencode-cowork-proxy/releases/download/v2.2.2/opencode-cowork-proxy"
  sha256 "57106bece27ced0e95223e441a1b0a2e9845947b3ffcb609b57a5f0b5e05bb49"

  def install
    bin.install "opencode-cowork-proxy"
  end

  def post_install
    safe_system "launchctl", "kickstart", "-k", "gui/#{Process.uid}/homebrew.mxcl.opencode-cowork-proxy"
  end

  service do
    run [opt_bin/"opencode-cowork-proxy"]
    environment_variables PORT: "18787", VERSION: "2.2.2"
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
