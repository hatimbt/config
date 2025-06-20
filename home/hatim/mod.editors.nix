{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Merge system-wide and home Info manuals top level directory.
  programs.info.enable = true;
  programs.emacs = {
    enable = false;
    package = pkgs.emacs-overlay.emacs-git-pgtk;
    extraPackages = (
      epkgs: [
        epkgs.treesit-grammars.with-all-grammars
      ]
    );
  };

  programs.emacs-emx = {
    enable = true;
    package = pkgs.emacs;
    #package = pkgs.emacs-overlay.emacs-git-pgtk;
    defaultEditor = true;
    treesitGrammars = [
      "all"
    ];
    localPath = "${config.home.homeDirectory}/src/emx";
  };

  programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        github.copilot

        # Version-control
        mhutchie.git-graph
        eamodio.gitlens # Git enhancements

        # Programming Languages
        jnoortheen.nix-ide # Nix
        ms-python.python # Python support
        ms-toolsai.jupyter # Jupyter Notebook support
        ms-vscode.cpptools # C/C++ support
        rust-lang.rust-analyzer # Rust support
        golang.go # Go support
        redhat.java # Java support
        dart-code.dart-code # Dart/Flutter support
        svelte.svelte-vscode # Svelte support

        # Web Development
        dbaeumer.vscode-eslint # Linting for JavaScript/TypeScript
        ritwickdey.liveserver # Live server for web development
        bradlc.vscode-tailwindcss # Tailwind CSS support

        # DevOps and Cloud
        ms-azuretools.vscode-docker # Docker support
        hashicorp.terraform # Terraform support
        redhat.ansible # Ansible support

        # Productivity
        fill-labs.dependi # Dependency
        esbenp.prettier-vscode # Code formatter
        johnpapa.vscode-peacock # Change VSCode theme
        yzhang.markdown-all-in-one # Markdown support
        shardulm94.trailing-spaces # Highlight trailing spaces
        tamasfe.even-better-toml # TOML support
        alefragnani.bookmarks # Code bookmarks
        editorconfig.editorconfig # EditorConfig support
        gruntfuggly.todo-tree # Highlight TODO comments
      ];
    };
  };

  # Zed
  # TODO Broken for now, come back to this later
  # programs.zed-editor = {
  #   enable = true;
  #   package = inputs.zed-editor.packages.${pkgs.system}.zed-editor;
  #   extensions = [
  #     "beancount"
  #     "nix"
  #     "make"
  #     "just"
  #     "sql"
  #     "dockerfile"
  #     "docker-compose"
  #     "helm"
  #   ];
  # };

  # Extra Editors
  programs.neovim.enable = false;
  programs.helix.enable = true;
  programs.kakoune.enable = true;

  home.packages = [
    pkgs.texmacs
    pkgs.lyx
    pkgs.leo-editor

    inputs.zed-editor.packages.${pkgs.system}.zed-editor-bin-fhs
    pkgs.windsurf #broken
    pkgs.code-cursor
    pkgs.vscodium-fhs

    # JetBrains IDEs
    pkgs.jetbrains.rust-rover
    pkgs.jetbrains.pycharm-community-bin
    pkgs.jetbrains.webstorm
  ];
}
