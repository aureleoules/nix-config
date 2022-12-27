{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "editor.fontFamily" = "mononoki Nerd Font";
      "editor.fontWeight" = "bold";
      "workbench.colorTheme" = "Ayu Dark Bordered";
      "java.jdt.ls.java.home" = "/home/aureleoules/.nix-profile/lib/openjdk";
      "java.configuration.runtimes" = [
        {
          "name" = "JavaSE-16";
          "path" = "/home/aureleoules/.nix-profile/lib/openjdk";
        }
      ];
      "sonarlint.ls.javaHome" = "/nix/store/500hgnsk77cs40fmhmq3hv47kyvfaq69-openjdk-17.0.4+8/lib/openjdk";
      "ui.diagnostic.staticcheck" = true;
      "C_Cpp.default.cppStandard" = "c++20";
      "github.copilot.enable" = {
        "*" = true;
        "yaml" = true;
        "plaintext" = true;
        "markdown" = true;
      };
      "editor.inlineSuggest.enabled" = true;
      "[svelte]" = {
        "editor.defaultFormatter" = "svelte.svelte-vscode";
      };
       "diffEditor.renderSideBySide" = false;
      # "editor.formatOnSave" = true;
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
        name = "vim";
        publisher = "vscodevim";
        version = "1.21.10";
        sha256 = "0c9m7mc2kmfzj3hkwq3d4hj43qha8a75q5r1rdf1xfx8wi5hhb1n";
      }
      {
        name = "Go";
        publisher = "golang";
        version = "0.29.0";
        sha256 = "1ky5xnl300m42ja8sh3b4ynn8k1nnrcbxxhn3c3g5bsyzsrr1nmz";
      }
    ];
  };
}

