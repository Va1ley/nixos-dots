{ pkgs, ... }:

{
    programs.dank-material-shell = {
        enable = true;
        # quickshell.package = pkgs.quickshell;
    };
}
