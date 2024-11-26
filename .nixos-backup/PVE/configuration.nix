{ config, lib, pkgs, ... }:

{
    users.users.kanrisha = {
       isNormalUser = true;
       extraGroups = [
           "wheel"
       ];
    };
    
    nixpkgs.config.allowUnfree = true;
    
    environment.systemPackages = with pkgs; [
        wget
        curl
        docker
    ];
    
    
}