cask "antigravity-hub-linux" do
  version "2.0.0,6324554176528384"

  sha256 "14bc9cb480a5be8fb3b7dc3e2b0cebfa66d370ad58cc1e0fa01140d1204d4297"

  url "https://storage.googleapis.com/antigravity-public/antigravity-hub/#{version.csv.first}-#{version.csv.second}/linux-x64/Antigravity.tar.gz",
      verified: "storage.googleapis.com/antigravity-public/"
  name "Antigravity"
  desc "AI Coding Agent"
  homepage "https://antigravity.google/"

  binary "#{staged_path}/Antigravity-x64/antigravity"
  binary "#{staged_path}/Antigravity-x64/antigravity", target: "agy"

  artifact "antigravity.desktop",
           target: "#{Dir.home}/.local/share/applications/antigravity.desktop"
  artifact "antigravity-url-handler.desktop",
           target: "#{Dir.home}/.local/share/applications/antigravity-url-handler.desktop"

  preflight do
    FileUtils.mkdir_p "#{Dir.home}/.local/share/applications"

    File.write("#{staged_path}/antigravity.desktop", <<~EOS)
      [Desktop Entry]
      Name=Antigravity
      Comment=AI Coding Agent
      GenericName=Text Editor
      Exec="#{HOMEBREW_PREFIX}/bin/antigravity" %F
      Type=Application
      StartupNotify=false
      StartupWMClass=Antigravity
      Categories=TextEditor;Development;IDE;
      MimeType=text/plain;inode/directory;application/x-code-workspace;x-scheme-handler/antigravity;
      Actions=new-empty-window;
      Keywords=antigravity;code;editor;ai;

      [Desktop Action new-empty-window]
      Name=New Empty Window
      Exec="#{HOMEBREW_PREFIX}/bin/antigravity" --new-window %F
    EOS

    File.write("#{staged_path}/antigravity-url-handler.desktop", <<~EOS)
      [Desktop Entry]
      Name=Antigravity - URL Handler
      Comment=AI Coding Agent
      GenericName=Text Editor
      Exec="#{HOMEBREW_PREFIX}/bin/antigravity" --open-url "%U"
      Type=Application
      NoDisplay=true
      Terminal=false
      StartupNotify=true
      StartupWMClass=antigravity
      Categories=Utility;TextEditor;Development;IDE;
      MimeType=x-scheme-handler/antigravity;
      Keywords=antigravity;
    EOS
  end

  zap trash: [
    "~/.antigravity",
    "~/.config/Antigravity",
    "~/.config/antigravity",
  ]
end
