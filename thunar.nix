{
  config,
  pkgs,
  ...
}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };
}
