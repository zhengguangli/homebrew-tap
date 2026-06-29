class OpencodeCoworkProxy < Formula
  desc "API translation proxy for AI clients (Anthropic↔OpenAI)"
  homepage "https://github.com/zhengguangli/opencode-cowork-proxy"
  version "2.2.1"
  url "https://github.com/zhengguangli/opencode-cowork-proxy/releases/download/v2.2.1/opencode-cowork-proxy"
  sha256 "8970ac3af63442640d6938121490ae8b538f9b7c03adb112a9e89423e9453b47"

  def install
    bin.install "opencode-cowork-proxy"
    plist = "#{ENV["HOME"]}/Library/LaunchAgents/homebrew.mxcl.opencode-cowork-proxy.plist"
    if File.exist?(plist)
      uid = Process.uid
      label = "homebrew.mxcl.opencode-cowork-proxy"
      system "launchctl", "kickstart", "-k", "gui/#{uid}/#{label}"
    end
  end

  service do
    run [opt_bin/"opencode-cowork-proxy"]
    environment_variables PORT: "18787", VERSION: "2.2.1"
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
