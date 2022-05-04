{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "editor.fontFamily" = "mononoki Nerd Font";
      "editor.fontWeight" = "bold";
      "workbench.colorTheme" = "Black";
      "java.jdt.ls.java.home" = "/home/aureleoules/.nix-profile/lib/openjdk";
      "java.configuration.runtimes" = [
        {
          "name" = "JavaSE-16";
          "path" = "/home/aureleoules/.nix-profile/lib/openjdk";
        }
      ];
      "ui.diagnostic.staticcheck" = true;
      "C_Cpp.default.cppStandard" = "c++20";
      "github.copilot.enable" = {
        "*" = true;
        "yaml" = true;
        "plaintext" = true;
        "markdown" = true;
      };
      "editor.inlineSuggest.enabled" = true;
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
      {
        name = "svelte-vscode";
        publisher = "Svelte";
        version = "105.5.0";
        sha256 = "1alchxaac1584dd5402zwwpyxxy4d3rkii2hcmvm1p8lglvdlsgn";
      }
      {
        name = "Go";
        publisher = "golang";
        version = "0.29.0";
        sha256 = "1ky5xnl300m42ja8sh3b4ynn8k1nnrcbxxhn3c3g5bsyzsrr1nmz";
      }
      {
        name = "rust-analyzer";
        publisher = "matklad";
        version = "0.2.834";
        sha256 = "sha256-G5uBHDfm3JTXt1NtCLZVmrcxMJx5ZIIvnbtwu16iquA=";
      }
      {
        name = "shell-format";
        publisher = "foxundermoon";
        version = "7.2.2";
        sha256 = "sha256-cec5ICfUOxmszVvuwOH3fWsH4UuSm9rXFVq2y4UHjAM=";
      }
    ];
  };
}

