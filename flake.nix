{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
};

  outputs = {self, nixpkgs, ... }@inputs:
    let
      cfg = { hostname, system ? "x86_64-linux", modules ? [ ] }: {
        nixosConfigurations = {
          ${hostname} = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs self; };
            modules = [
              ./hardware/${hostname}.nix
              ./modules/${hostname}.nix
              ./modules/common.nix
              { networking.hostName = hostname; }
            ] ++ modules;
          };
        };
      };
    in nixpkgs.lib.recursiveUpdate (nixpkgs.lib.recursiveUpdate { } (cfg { hostname = "mdesk2"; })) (cfg {hostname="mlap2";});

}
