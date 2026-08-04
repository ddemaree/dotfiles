{ pkgs, ... }:

{
  programs.direnv.enable = true;

  programs.git.enable = true;
  programs.lazygit.enable = true;

  environment.systemPackages = with pkgs; [
    delta
    python3
    # bun
    # nodejs_22
    # pnpm_9
    # nodePackages_latest.nodejs
    # nodePackages_latest.pnpm

    mold
    gcc
    gnumake
    gnupg
    clang
    lld
    lldb
    musl
    jdk11

    ddev
    dioxus-cli
    trunk
    devenv
    sops
    rops
    lefthook
    pre-commit-hook-ensure-sops
    diffnav
    sqlx-cli
    license-generator
    git-ignore
    gitleaks
    pass-git-helper
    jujutsu
    jjui
    just
    mise
    gh
    gh-dash
    hurl
    grex
    # surrealdb
    # surrealdb-migrations
    # surrealist

    # Language servers & tools
    python313Packages.python-lsp-server
    ty
    ruff
    nodePackages_latest.nodemon
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    eslint
    biome
    rubyPackages.htmlbeautifier
    nodePackages_latest.vscode-langservers-extracted
    superhtml
    jsonnet-language-server
    nodePackages_latest.yaml-language-server
    taplo # toml formatter & lsp
    tombi
    nodePackages_latest.bash-language-server
    nodePackages_latest.graphql-language-service-cli
    dockerfile-language-server
    vue-language-server
    lua-language-server
    marksman
    markdown-oxide
    nil
    nixd
    zls
    gopls
    delve
    emmet-language-server
    buf
    protols
    cmake-language-server
    neocmakelsp
    just-lsp
    docker-compose-language-service
    slint-lsp
    hyprls
    fish-lsp
    # terraform-ls
    # helix-gpt
    # vscode-extensions.vadimcn.vscode-lldb
    # wasm-language-tools
    # nix-ai-tools.copilot-language-server
  ];
}
