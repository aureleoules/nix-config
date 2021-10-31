{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "editor.fontFamily" = "mononoki Nerd Font";
      "editor.fontWeight" = "bold";
      "workbench.colorTheme" = "Black";
    };

    extensions = (with pkgs.vscode-extensions; [
      ms-vscode.cpptools
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Black";
        publisher = "Jaakko";
        version = "0.12.0";
        sha256 = "0d75w81p1jiq8zpky0p1jdvxyc2pnpmnp05ga2hsbq88w2chqh3c";
      }
      {
        name = "copilot";
        publisher = "Github";
        version = "1.6.3571";
        sha256 = "00sw75my466mzsrqjafzxbzv397vmlfafllbljvql6crxpl45v57";
      }
      {
        name = "vim";
        publisher = "vscodevim";
        version = "1.21.10";
        sha256 = "0c9m7mc2kmfzj3hkwq3d4hj43qha8a75q5r1rdf1xfx8wi5hhb1n";
      }
    ];
  };
}

