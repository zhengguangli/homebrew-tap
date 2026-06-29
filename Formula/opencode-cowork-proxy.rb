class OpencodeCoworkProxy < Formula
  desc "API translation proxy for AI clients (Anthropic↔OpenAI)"
  homepage "https://github.com/zhengguangli/opencode-cowork-proxy"
  version "2.2.0"
  url "https://github.com/zhengguangli/opencode-cowork-proxy/releases/download/v2.2.0/opencode-cowork-proxy"
  sha256 "b587dc189e962f7cb22182ddfa9b0d52fd1fd5c25ec780aa1c65f6439baed3f3"

  def install
    bin.install "opencode-cowork-proxy"
  end

  def post_install
    plist = "\#{ENV["HOME"]}/Library/LaunchAgents/homebrew.mxcl.opencode-cowork-proxy.plist"
    if File.exist?(plist)
      uid = Process.uid
      label = "homebrew.mxcl.opencode-cowork-proxy"
      system "launchctl", "kickstart", "-k", "gui/\#{uid}/\#{label}"
    end
  end

  service do
    run [opt_bin/"opencode-cowork-proxy"]
    environment_variables PORT: "18787", VERSION: "2.2.0"
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
