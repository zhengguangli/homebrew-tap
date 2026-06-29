class OpencodeCoworkProxy < Formula
  desc "API translation proxy for AI clients (Anthropic↔OpenAI)"
  homepage "https://github.com/zhengguangli/opencode-cowork-proxy"
  version "2.1.5"
  url "https://github.com/zhengguangli/opencode-cowork-proxy/releases/download/v2.1.5/opencode-cowork-proxy"
  sha256 "f49b7f368c4f1935bfc1f6f50175b984b38bcbbf3dc78f5c657b127527ab4965"

  def install
    bin.install "opencode-cowork-proxy"
  end

  service do
    run [opt_bin/"opencode-cowork-proxy"]
    environment_variables PORT: "18787", VERSION: "2.1.5"
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
