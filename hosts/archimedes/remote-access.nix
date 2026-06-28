{ config, ... }:

{
  services.tailscale = {
    enable = true;
  };

  # Tailscale に通常 DNS を触れせない方針
  services.tailscale.extraUpFlags = [
    "--accept-dns=false"
  ];

  networking.firewall = {
    enable = true;

    # Tailscale/WireGuard の受信 UDP port を許可
    allowedUDPPorts = [ config.services.tailscale.port ];

    # tailnet 経由では SSH だけ許可する
    # trustedInterfaces = [ config.services.tailscale.interfaceName ];
    # より狭いので、最初はこちらを推奨
    interfaces.${config.services.tailscale.interfaceName}.allowedTCPPorts = [ 22 ];
  };

  services.openssh = {
    enable = true;

    # 22/tcp を全 interface に開けない。
    # SSH は tailscale0 側だけ firewall で許可する。
    openFirewall = false;

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PubkeyAuthentication = true;
      PermitRootLogin = "no";

      # 念のためログイン可能ユーザーを限定
      AllowUsers = [ "kkinugasa" ];
    };
  };

  # 公開鍵はディレクトリに置く方針
  # users.users.kkinugasa.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AAAA... your-key-comment"
  # ];
}
