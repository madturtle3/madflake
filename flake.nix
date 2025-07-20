{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      cfg =
        {
          hostname,
          arch ? "x86_64-linux",
          modules ? [ ],
        }:
        {
          nixosConfigurations = {
            ${hostname} = nixpkgs.lib.nixosSystem {
              # declare the system (probably x86 who knows)
              system = arch;
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
    in
    # so this takes the list of hosts and makes automatically the output based on provided arguments
    nixpkgs.lib.foldl' (acc: x: (nixpkgs.lib.recursiveUpdate acc (cfg x))) { } [
      { hostname = "mdesk2"; }
      { hostname = "mlap2"; }
    ];

}
