# Putty Usage

## Tunnel

- Tunnel is used to forward local port to a remote machine port

This is used to get around firewall, e.g, local has access to servier but has no access to ms sql db on server. So, request to local port 3341 will be forward to server:3341. In this way, it is like accessing from the server local.

Putty Configuration ::> Connectioin ::> SSH ::> Tunnels ::> Add new forwarded port

eg., Source, 3341, Destination, 222.333.44.55:3341,

Then click on "Add" button.
