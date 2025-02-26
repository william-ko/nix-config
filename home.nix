{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "billkontos";
  home.homeDirectory = "/Users/billkontos";

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.neovim
    pkgs.iterm2
    pkgs.mkalias
    pkgs.duckdb
    pkgs.direnv
    pkgs.zellij
    pkgs.rustup
    pkgs.nixfmt-rfc-style
    pkgs.git
    pkgs.gh
    pkgs.delta
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.google-cloud-sdk
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim".source = ./dotfiles/nvim;
    ".config/zellij".source = ./dotfiles/zellij;
    ".gitconfig" = {
      executable = false;
      text = ''
        [user]
          name = william-ko
          email = bill.kontos@vetspire.com

        [color]
          ui = true

        [core]
          pager = delta
          editor = vim

        [interactive]
          diffFilter = delta --color-only

        [delta]
          features = side-by-side line-numbers decorations
          whitespace-error-style = 22 reverse

        [delta "decorations"]
          commit-decoration-style = bold yellow box ul
          file-style = bold yellow ul
          file-decoration-style = none

        [alias]
          # GH Core aliases
          gh          = "!f() { gh $@; \n }; f"
          gist        = "!f() { gh gist $@; \n }; f"
          issue       = "!f() { gh issue $@; \n }; f"
          pr          = "!f() { gh pr $@; \n }; f"
          release     = "!f() { gh release $@; \n }; f"
          repo        = "!f() { gh repo $@; \n }; f"

          alias       = "!f() { gh alias $@; \n }; f"
          api         = "!f() { gh api $@; \n }; f"
          auth        = "!f() { gh auth $@; \n }; f"
          completion  = "!f() { gh completion $@; \n }; f"
          config      = "!f() { gh config $@; \n }; f"
          secret      = "!f() { gh secret $@; \n }; f"
          ssh-key     = "!f() { gh ssh-key $@; \n }; f"

          # Custom aliases
          push-origin = "!f() { git push origin -u $(git rev-parse --abbrev-ref HEAD) $@; \n }; f"
          rewrite     = "!f() { git rebase -i HEAD~$1; \n }; f"
          gloat       = "!f() { git shortlog -sn; \n }; f"
          root        = "!f() { git rev-parse --path-format=absolute --show-toplevel; \n }; f"
          ssh-migrate = "!f() { $HOME/.local/bin/git/ssh-migrate.sh \n }; f"
      '';
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.lazygit.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      prmain = "git pull --rebase origin main";
      prmaster = "git pull --rebase origin master";
      prstaging = "git pull --rebase origin staging";
      prprod = "git pull --rebase origin production";
      amend = "git commit --amend";
      gco = "git checkout";
      up = "mix deps.get && mix phx.server";
      vetapi = "cd ~/Development/vetspire/api && nvim .";
      vetweb = "cd ~/Development/vetspire/web && nvim .";
      cdvet = "cd ~/Development/vetspire";
      cdapi = "cd ~/Development/vetspire/api";
      cdweb = "cd ~/Development/vetspire/web";
      z = "zellij";
    };
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "bira";
  };
}
