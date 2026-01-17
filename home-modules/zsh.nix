{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.lsd
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
      ignoreSpace = true;
    };

    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
    ];

    # .zshrc
    initContent = ''
      # pywal
      # (cat ~/.cache/wal/sequences &)

      # Configuration of powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # Configuration of historySubstringSearch
      zmodload zsh/terminfo
      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down
      #bindkey '^[[A' history-substring-search-up
      #bindkey '^[OA' history-substring-search-up
      #bindkey '^[[B' history-substring-search-down
      #bindkey '^[OB' history-substring-search-down
    '';

    shellAliases = {
      update = "sudo nixos-rebuild-secure switch --flake ~/nixos-config/ --impure";
      clean = "sudo nix-collect-garbage -d";
      dockerclean = "sudo docker system prune -a";
      journalclean = "sudo journalctl --vacuum-time=7d";
      vpniut = "sudo openfortivpn u-vpn-plus.unilim.fr --saml-login";
      bdd = "nvim +':DBUI' ";
      avante = "nvim -c 'lua vim.defer_fn(function()require(\"avante.api\").zen_mode()end, 100)'";
      ls = "eza -1 --icons=auto";
      c = "clear";
      l = "eza -lh --icons=auto";
      ll = "eza -lha --icons=auto --sort=name --group-directories-first";
      ld = "eza -lhD --icons=auto";
      lt = "eza --icons=auto --tree";
      ".." = "cd ..";
      "..." = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";
      mkdir = "mkdir -p";
      search = "sudo find . -iname ";
      searchin = "sudo grep -rnw . -e ";
      setwallpaper = "/set_wallpaper.s";
      startweb = "sudo systemctl start httpd && systemctl status httpd && sudo systemctl start mariadb && systemctl status mariadb";
      rmnot = "sudo ~/rmnot.sh";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    options = ["--cmd cd"];
  };
}
